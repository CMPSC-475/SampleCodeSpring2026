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
                .border(.red)
                .position(x: element.boundingRect.cgRect.midX, y: element.boundingRect.cgRect.midY)
                .border(.blue)
                
        case .square:
            Rectangle()
                .stroke(element.color, lineWidth: lineWidth)
                .frame(width: element.boundingRect.cgRect.width, height: element.boundingRect.cgRect.height)
                .border(.red)
                .position(x: element.boundingRect.cgRect.midX, y: element.boundingRect.cgRect.midY)
                .border(.blue)
        case .triangle:
            TriangleShape()
                .stroke(element.color, lineWidth: lineWidth)
                .frame(width: element.boundingRect.cgRect.width, height: element.boundingRect.cgRect.height)
                .border(.red)
                .position(x: element.boundingRect.cgRect.midX, y: element.boundingRect.cgRect.midY)
                .border(.blue)
        case .freeform:
            let rect = element.boundingRect.cgRect
            let localPoints = element.points.cgPointsCollection.map {
                CGPoint(x: $0.x - rect.minX, y: $0.y - rect.minY)
            }
            
            FreeformShape(points: localPoints)
                .stroke(element.color, lineWidth: lineWidth)
                .frame(width: rect.width, height: rect.height)
                .border(.red)
                .position(x: rect.midX, y: rect.midY)
                .border(.blue)
        }
    }
}

