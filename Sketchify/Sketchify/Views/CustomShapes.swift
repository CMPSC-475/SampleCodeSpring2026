//
//  CustomShapes.swift
//  Sketchify
//
//  Created by Nader Alfares on 1/26/26.
//
import SwiftUI

//MARK: TriangleShape
struct TriangleShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        //TODO: -
        return path
    }
}


//MARK: FreeformShape
struct FreeformShape: Shape {
    let points: [CGPoint]
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        //TODO: -
        return path
    }
}



//#Preview {
//    let lineWidth : CGFloat = 5
//    let fillColor: Color = .cyan
//    
//    let carPoints: [CGPoint] = [
//        CGPoint(x: 10, y: 40),  // rear bumper
//        CGPoint(x: 20, y: 30),  // rear slope
//        CGPoint(x: 30, y: 25),
//        CGPoint(x: 45, y: 25),  // roof start
//        
//        CGPoint(x: 55, y: 10),  // roof top rear
//        CGPoint(x: 75, y: 10),  // roof top front
//        
//        CGPoint(x: 85, y: 25),  // roof drop
//        CGPoint(x: 95, y: 30),  // front slope
//        CGPoint(x: 100, y: 40), // front bumper
//        
//        // front wheel arch
//        CGPoint(x: 85, y: 40),
//        CGPoint(x: 80, y: 48),
//        CGPoint(x: 72, y: 48),
//        CGPoint(x: 65, y: 40),
//        
//        // bottom edge
//        CGPoint(x: 45, y: 40),
//        
//        // rear wheel arch
//        CGPoint(x: 35, y: 40),
//        CGPoint(x: 30, y: 48),
//        CGPoint(x: 22, y: 48),
//        CGPoint(x: 15, y: 40),
//        
//        CGPoint(x: 10, y: 40)   // back to start
//    ]
//    ZStack {
//        TriangleShape()
//            .stroke(Color.red, lineWidth: lineWidth)
//            .fill(.blue)
//            .frame(width: 100, height: 100)
//        
//        FreeformShape(points: carPoints)
//            .stroke(.red, lineWidth: lineWidth)
//            
//    }
//}


