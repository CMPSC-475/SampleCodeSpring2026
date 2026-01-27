//
//  ToolbarButtons.swift
//  Sketchify
//
//  Created by Nader Alfares on 1/26/26.
//

import SwiftUI




struct CompactToolButton: View {
    let icon: String
    let label: String
    var color: Color = .primary
    var isEnabled: Bool = true
    var isSelected: Bool = false
    var isHighlighted: Bool = false
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(backgroundColor)
                        .frame(width: 48, height: 48)
                    
                    if isSelected || isHighlighted {
                        RoundedRectangle(cornerRadius: 10)
                            .strokeBorder(color, lineWidth: 2)
                            .frame(width: 48, height: 48)
                    }
                    
                    Image(systemName: icon)
                        .font(.system(size: 22))
                        .symbolRenderingMode(.hierarchical)
                        .foregroundStyle(iconColor)
                }
                
                Text(label)
                    .font(.caption2)
                    .fontWeight(isSelected ? .semibold : .regular)
                    .foregroundStyle(isEnabled ? (isSelected ? color : .secondary) : .gray)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
            }
            .frame(minWidth: 60)
        }
        .buttonStyle(.plain)
        .disabled(!isEnabled)
        .opacity(isEnabled ? 1 : 0.5)
    }
    
    private var backgroundColor: Color {
        if isSelected {
            return color.opacity(0.15)
        } else if isHighlighted {
            return color.opacity(0.1)
        } else {
            return Color(uiColor: .systemGray6)
        }
    }
    
    private var iconColor: Color {
        if !isEnabled {
            return .gray
        } else if isSelected {
            return color
        } else {
            return .primary
        }
    }
}
