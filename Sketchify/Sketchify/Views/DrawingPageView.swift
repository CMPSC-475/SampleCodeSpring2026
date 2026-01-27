//
//  DrawingPageView.swift
//  Sketchify
//
//  Created by Nader Alfares on 1/26/26.
//
import SwiftUI



struct DrawingPageView: View {
    @Environment(\.dismiss) private var dismiss
    
    let pageId: UUID
    let onSave: (DrawingPage) -> Void
    
    @State private var selectedTool: DrawingTool = .freeform
    @State private var drawingElements: [DrawingElement] = []
    
    
    
    //tracking view related states
    @State private var currentPoints: [CGPoint] = []
    @State private var currentColor: Color = .black

    @State private var pageTitle: String = ""
    @State private var isEditingTitle: Bool = false
    
    // TODO: make this configurable
    @State private var lineWidth: CGFloat = 2
    @State private var backgroundColor: Color = .white
    

    
    var body: some View {
        VStack(spacing: 0) {
            // Drawing Canvas
            ZStack {
                backgroundColor
                    .ignoresSafeArea()
                
                // Draw all saved elements
                ForEach(drawingElements) { element in
                    DrawingElementView(element: element)
                }
                
                // Draw current shape being created
                if currentPoints.count >= 2 || (currentPoints.count >= 1 && selectedTool == .freeform) {
                    Group {
                        switch selectedTool {
                        case .circle:
                            let rect = calculateBoundingRect(from: currentPoints)
                            Ellipse()
                                .stroke(currentColor, lineWidth: lineWidth)
                                .frame(width: rect.width, height: rect.height)
                                .position(x: rect.midX, y: rect.midY)
                        case .square:
                            let rect = calculateBoundingRect(from: currentPoints)
                            Rectangle()
                                .stroke(currentColor, lineWidth: lineWidth)
                                .frame(width: rect.width, height: rect.height)
                                .position(x: rect.midX, y: rect.midY)
                        case .triangle:
                            let rect = calculateBoundingRect(from: currentPoints)
                            TriangleShape()
                                .stroke(currentColor, lineWidth: lineWidth)
                                .frame(width: rect.width, height: rect.height)
                                .position(x: rect.midX, y: rect.midY)
                        case .freeform:
                            FreeformShape(points: currentPoints)
                                .stroke(currentColor, lineWidth: lineWidth)
                        }
                    }
                }
            }
            //TODO: add gesture
            
            // Unified Bottom Toolbar
            UnifiedToolbarButtons(currentColor: $currentColor, selectedTool: $selectedTool, undoEnabled: !drawingElements.isEmpty, clearEnabled: !drawingElements.isEmpty) {
                undo()
            } clear: {
                drawingElements.removeAll()
                saveCurrentState()
            }

            
            
        }
        .navigationTitle(pageTitle)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    isEditingTitle = true
                }) {
                    Image(systemName: "pencil.circle.fill")
                        .symbolRenderingMode(.hierarchical)
                }
            }
        }
        .alert("Edit Title", isPresented: $isEditingTitle) {
            TextField("Title", text: $pageTitle)
            Button("Cancel", role: .cancel) { }
            Button("Save") {
                saveCurrentState()
            }
        }

    }
    
    // MARK: - Helper Functions
    private func calculateBoundingRect(from points: [CGPoint]) -> CGRect {
        guard points.count >= 2 else { return .zero }
        let minX = min(points[0].x, points.last!.x)
        let minY = min(points[0].y, points.last!.y)
        let maxX = max(points[0].x, points.last!.x)
        let maxY = max(points[0].y, points.last!.y)
        return CGRect(x: minX, y: minY, width: maxX - minX, height: maxY - minY)
    }
    
    private func undo() {
        guard !drawingElements.isEmpty else { return }
        drawingElements.removeLast()
        saveCurrentState()
    }
    
    
    private func saveCurrentState() {
        let updatedPage = DrawingPage(
            id: pageId,
            title: pageTitle,
            elements: drawingElements
        )
        onSave(updatedPage)
    }
    
    // MARK: - Initializer
    init(page: DrawingPage, onSave: @escaping (DrawingPage) -> Void) {
        self.pageId = page.id
        self.onSave = onSave
        self._drawingElements = State(initialValue: page.elements)
        self._pageTitle = State(initialValue: page.title)
    }
}



struct UnifiedToolbarButtons : View {
    @State private var showColorPicker: Bool = false
    
    
    // Available color palette - Extended with more colors
    private let availableColors: [Color] = [
        .black, .white, .gray,
        .red, .orange, .yellow,
        .green, .mint, .teal,
        .cyan, .blue, .indigo,
        .purple, .pink, .brown
    ]
    
    // All available tools organized in an order that we want
    private let allTools: [DrawingTool] = [
        .freeform, .circle, .square, .triangle,
    ]
    
    
    
    
    // Drawing page view variables that are also passed
    // to this view
    @Binding var currentColor : Color
    @Binding var selectedTool : DrawingTool
    var undoEnabled : Bool
    var clearEnabled : Bool
    var undo : () -> Void
    var clear : () -> Void

    
    
    var body : some View {
        VStack(spacing: 0) {
            Divider()
            
            // Color Picker Expandable Section
            if showColorPicker {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(availableColors, id: \.self) { color in
                            Button(action: {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                    currentColor = color
                                }
                            }) {
                                ZStack {
                                    Circle()
                                        .fill(color)
                                        .frame(width: 44, height: 44)
                                        .overlay(
                                            Circle()
                                                .strokeBorder(color == .white ? Color.gray.opacity(0.3) : Color.clear, lineWidth: 1)
                                        )
                                        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
                                    
                                    if currentColor.colorComponents.red == color.colorComponents.red &&
                                       currentColor.colorComponents.green == color.colorComponents.green &&
                                       currentColor.colorComponents.blue == color.colorComponents.blue {
                                        Circle()
                                            .strokeBorder(.blue, lineWidth: 3)
                                            .frame(width: 50, height: 50)
                                        
                                        Image(systemName: "checkmark")
                                            .font(.caption.weight(.bold))
                                            .foregroundStyle(color == .white || color == .yellow ? .black : .white)
                                    }
                                }
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                }
                .background(Color(uiColor: .systemGray6))
                .transition(.move(edge: .bottom).combined(with: .opacity))
                
                Divider()
            }
            
            // Main Unified Toolbar - Scrollable
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    // Action Buttons Section
                    Group {
                        // Undo Button
                        CompactToolButton(
                            icon: "arrow.uturn.backward",
                            label: "Undo",
                            color: .blue,
                            isEnabled: undoEnabled
                        ) {
                            undo()
                        }
                        
                        // Color Picker Toggle
                        CompactToolButton(
                            icon: "paintpalette.fill",
                            label: "Colors",
                            color: currentColor,
                            isHighlighted: showColorPicker
                        ) {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                showColorPicker.toggle()
                            }
                        }
                        
                        // Clear Button
                        CompactToolButton(
                            icon: "trash.fill",
                            label: "Clear",
                            color: .red,
                            isEnabled: clearEnabled
                        ) {
                            clear()
                        }
                    }
                    
                    // Visual Separator
                    Divider()
                        .frame(height: 48)
                        .padding(.horizontal, 4)
                    
                    // Drawing Tools Section
                    ForEach(allTools, id: \.self) { tool in
                        CompactToolButton(
                            icon: tool.iconName,
                            label: tool.displayName,
                            color: currentColor,
                            isSelected: selectedTool == tool
                        ) {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                selectedTool = tool
                            }
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
            }
            .background(Color(uiColor: .systemBackground))
        }
    }
}




#Preview {
    NavigationStack {
        DrawingPageView(page: DrawingPage(title: "Preview Page")) { _ in }
    }
}

