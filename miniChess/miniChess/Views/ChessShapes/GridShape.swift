//
//  GridShape.swift
//  miniChess
//
//  Created by Nader Alfares on 2/2/26.
//
import SwiftUI

//struct Grid: Shape {
//    var gridSize: Int
//    
//    func path(in rect: CGRect) -> Path {
//        let path = Path()
//        //TODO: implement
//        return path
//    }
//}

struct Grid: Shape {
    var gridSize: Int
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        
        let size = CGFloat(gridSize)
        let cellWidth = rect.width / size
        let cellHeight = rect.height / size
        
    
        // Vertical Lines
        for i in 0...gridSize {
            let x = rect.minX + cellWidth * CGFloat(i)
            path.move(to: CGPoint(x: x, y: rect.minY))
            path.addLine(to: CGPoint(x: x, y: rect.maxY))
        }
        
        // Horizontal Lines
        for i in 0...gridSize {
            let y = rect.minY + cellHeight * CGFloat(i)
            path.move(to: CGPoint(x: rect.minX, y: y))
            path.addLine(to: CGPoint(x: rect.maxX, y: y))
        }
    
        return path
    }
}



#Preview {
    Grid(gridSize: 5)
        .stroke(.black)
        .frame(width: 300, height: 300)
        
}

