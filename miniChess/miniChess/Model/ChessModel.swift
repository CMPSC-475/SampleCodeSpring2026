//
//  ChessModel.swift
//  miniChess
//
//  Created by Nader Alfares on 2/2/26.
//


import Foundation

enum ChessPieceType : String, CaseIterable {
    case pawn, bishop, rook, knight, king, queen
}

enum ChessColor : String, CaseIterable {
    case white, black
}

struct Position: Hashable {
    var row: Int
    var col: Int
}

struct ChessPiece : Identifiable {
    var id : UUID = UUID()
    var position : Position
    var type : ChessPieceType
    var color : ChessColor

}

struct ChessBoard : Identifiable {
    var id : UUID = UUID()
    var pieces : [ChessPiece] = []
    
    //TODO: - update for other configuration
    var gridSize : Int = 5
    
    init() {
        pieces.append(ChessPiece(position: Position(row: 0, col: 0), type: .rook, color: .black))
        pieces.append(ChessPiece(position: Position(row: 4, col: 0), type: .rook, color: .white))
        
        pieces.append(ChessPiece(position: Position(row: 0, col: 2), type:.bishop, color: .black))
        pieces.append(ChessPiece(position: Position(row: 4, col: 2), type:.bishop, color: .white))
        
        pieces.append(ChessPiece(position: Position(row: 0, col: 3), type:.queen, color: .black))
        pieces.append(ChessPiece(position: Position(row: 4, col: 3), type:.queen, color: .white))
        
        pieces.append(ChessPiece(position: Position(row: 0, col: 4), type:.king, color: .black))
        pieces.append(ChessPiece(position: Position(row: 4, col: 4), type:.king, color: .white))
        
        pieces.append(ChessPiece(position: Position(row: 1, col: 3), type: .pawn, color: .black))
        pieces.append(ChessPiece(position: Position(row: 3, col: 3), type: .pawn, color: .white))
        pieces.append(ChessPiece(position: Position(row: 1, col: 2), type: .pawn, color: .black))
        pieces.append(ChessPiece(position: Position(row: 3, col: 2), type: .pawn, color: .white))
    }
    
}
