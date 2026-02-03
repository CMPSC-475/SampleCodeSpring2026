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
        let path = Path()
    
        return path
    }
}



#Preview {
    Grid(gridSize: 5)
        .stroke(.black)
        .frame(width: 300, height: 300)
        
}

