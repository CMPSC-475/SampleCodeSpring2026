//
//  Card.swift
//  MindFlip
//
//  Created by Nader Alfares on 1/14/26.
//
import Foundation

enum CardShape: String, CaseIterable{
    case car, globe, heart, star, circle,square, triangle, diamond, hexagon
    var imageName : String {
        switch self {
                case .car:       return "car.fill"
                case .globe:     return "globe"
                case .heart:     return "heart.fill"
                case .star:      return "star.fill"
                case .circle:    return "circle.fill"
                case .square:    return "square.fill"
                case .triangle:  return "triangle.fill"
                case .diamond:   return "diamond.fill"
                case .hexagon:   return "hexagon.fill"
        }
    }
}


struct Card: Identifiable, Equatable {
    let id = UUID()
    let shape: CardShape
    var isFaceUp = false
    var isMatched = false
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        lhs.id == rhs.id
    }
    
    
}

