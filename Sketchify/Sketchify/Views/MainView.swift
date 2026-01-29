//
//  ContentView.swift
//  Sketchify
//
//  Created by Nader Alfares on 1/26/26.
//

import SwiftUI

struct MainView: View {
    @Environment(SketchifyManager.self) var manager: SketchifyManager
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 160), spacing: 16)], spacing: 16) {
                    ForEach(manager.drawingPages) { drawingPage in
                        NavigationLink {
                            DrawingPageView(page: drawingPage) { updatedPage in
                                manager.updatePage(updatedPage)
                            }
                        } label: {
                            DrawingPageCard(page: drawingPage)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding()
            }
            .navigationTitle("Sketchify")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        // Add new drawing page action
                        manager.addNewPage()
                    } label: {
                        Label("New Drawing", systemImage: "plus")
                    }
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        manager.deleteAllPages()
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }
                
            }
        }
    }
    
}

struct DrawingPageCard: View {
    let page: DrawingPage
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Thumbnail preview area
            RoundedRectangle(cornerRadius: 12)
                .fill(.ultraThinMaterial)
                .overlay {
                    Image(systemName: "paintbrush.pointed.fill")
                        .font(.system(size: 40))
                        .foregroundStyle(.secondary)

                }
                .aspectRatio(4/3, contentMode: .fit)
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .strokeBorder(.separator, lineWidth: 0.5)
                }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(page.title)
                    .font(.headline)
                    .foregroundStyle(.primary)
                    .lineLimit(2)
            }
            .padding(.horizontal, 4)
        }
        .padding(12)
        .background {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(uiColor: .systemBackground))
                .shadow(color: .black.opacity(0.1), radius: 8, y: 4)
        }
        .contentShape(RoundedRectangle(cornerRadius: 16))
    }
}




#Preview {
    let manager = SketchifyManager()
    var drawingPage = DrawingPage(title: "Demo")
    
    // Example circle (if you want to keep it)
    let circlePoints: [Point] = [
        Point(x: 100, y: 100),
        Point(x: 200, y: 200)
    ]
    
    var freeformPoints: [Point] = []
    for x in 50..<350 {
        // Use Double for sin(), then convert back to Float
        let xd = Double(x)
        let yd = 350.0 + 120.0 * sin(xd * 0.1)   // tweak 0.1 → frequency
        freeformPoints.append(
            Point(x: Float(xd), y: Float(yd))
        )
    }
    
    drawingPage.elements.append(DrawingElement(tool: .circle, points: circlePoints))
    drawingPage.elements.append(
        DrawingElement(tool: .freeform, points: freeformPoints)
    )
    manager.drawingPages.append(drawingPage)
    
    return MainView()
        .environment(manager)
}
