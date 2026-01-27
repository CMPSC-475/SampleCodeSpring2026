//
//  DrawingElementView.swift
//  Sketchify
//
//  Created by Nader Alfares on 1/26/26.
//
import SwiftUI


// MARK: - Drawing Shape View
struct DrawingElementView: View {
    let element: DrawingElement
    
    //TODO: make this user custom
    private let lineWidth: CGFloat = 5
    
    var body: some View {
        
        switch self.element.tool {
        case .circle:
            Ellipse()
                .stroke(element.color, lineWidth: lineWidth)
                .frame(width: element.boundingRect.cgRect.width, height: element.boundingRect.cgRect.height)
                .position(x: element.boundingRect.cgRect.midX, y: element.boundingRect.cgRect.midY)
        case .square:
            Rectangle()
                .stroke(element.color, lineWidth: lineWidth)
                .frame(width: element.boundingRect.cgRect.width, height: element.boundingRect.cgRect.height)
                .position(x: element.boundingRect.cgRect.midX, y: element.boundingRect.cgRect.midY)
        case .triangle:
            TriangleShape()
                .stroke(element.color, lineWidth: lineWidth)
                .frame(width: element.boundingRect.cgRect.width, height: element.boundingRect.cgRect.height)
                .position(x: element.boundingRect.cgRect.midX, y: element.boundingRect.cgRect.midY)
        case .freeform:
            FreeformShape(points: element.points.cgPointsCollection)
                .stroke(element.color, lineWidth: lineWidth)
        }
    }
}

