//
//  ChessManager+ValidMove.swift
//  miniChess
//
//  Created by Nader Alfares on 2/2/26.
//

extension ChessManager {
    
    func calculateValidMoves(for piece: ChessPiece) -> Set<Position> {
        var moves: Set<Position> = []
        
        switch piece.type {
        case .pawn:
            moves = calculatePawnMoves(for: piece)
        case .rook:
            moves = calculateRookMoves(for: piece)
        case .bishop:
            moves = calculateBishopMoves(for: piece)
        case .knight:
            moves = calculateKnightMoves(for: piece)
        case .queen:
            moves = calculateQueenMoves(for: piece)
        case .king:
            moves = calculateKingMoves(for: piece)
        }
        
        return moves
    }
    
    
    //MARK: Helper functions; private for this extension
    
    private func calculatePawnMoves(for piece: ChessPiece) -> Set<Position> {
        var moves: Set<Position> = []
        let direction = piece.color == .white ? -1 : 1
        
        // Forward move
        let forwardRow = piece.position.row + direction
        if isValid(row: forwardRow, col: piece.position.col) && getPiece(at: forwardRow, col: piece.position.col) == nil {
            moves.insert(Position(row: forwardRow, col: piece.position.col))
        }
        
        // Diagonal captures
        for colOffset in [-1, 1] {
            let captureCol = piece.position.col + colOffset
            if isValid(row: forwardRow, col: captureCol),
               let targetPiece = getPiece(at: forwardRow, col: captureCol),
               targetPiece.color != piece.color {
                moves.insert(Position(row: forwardRow, col: captureCol))
            }
        }
        
        return moves
    }
    
    private func calculateRookMoves(for piece: ChessPiece) -> Set<Position> {
        var moves: Set<Position> = []
        let directions = [(0, 1), (0, -1), (1, 0), (-1, 0)]
        
        for direction in directions {
            moves.formUnion(calculateLinearMoves(from: piece, direction: direction))
        }
        
        return moves
    }
    
    private func calculateBishopMoves(for piece: ChessPiece) -> Set<Position> {
        var moves: Set<Position> = []
        let directions = [(1, 1), (1, -1), (-1, 1), (-1, -1)]
        
        for direction in directions {
            moves.formUnion(calculateLinearMoves(from: piece, direction: direction))
        }
        
        return moves
    }
    
    private func calculateKnightMoves(for piece: ChessPiece) -> Set<Position> {
        var moves: Set<Position> = []
        let knightMoves = [
            (2, 1), (2, -1), (-2, 1), (-2, -1),
            (1, 2), (1, -2), (-1, 2), (-1, -2)
        ]
        
        for move in knightMoves {
            let newRow = piece.position.row + move.0
            let newCol = piece.position.col + move.1
            
            if isValid(row: newRow, col: newCol) {
                if let targetPiece = getPiece(at: newRow, col: newCol) {
                    if targetPiece.color != piece.color {
                        moves.insert(Position(row: newRow, col: newCol))
                    }
                } else {
                    moves.insert(Position(row: newRow, col: newCol))
                }
            }
        }
        
        return moves
    }
    
    private func calculateQueenMoves(for piece: ChessPiece) -> Set<Position> {
        var moves: Set<Position> = []
        moves.formUnion(calculateRookMoves(for: piece))
        moves.formUnion(calculateBishopMoves(for: piece))
        return moves
    }
    
    private func calculateKingMoves(for piece: ChessPiece) -> Set<Position> {
        var moves: Set<Position> = []
        let directions = [
            (0, 1), (0, -1), (1, 0), (-1, 0),
            (1, 1), (1, -1), (-1, 1), (-1, -1)
        ]
        
        for direction in directions {
            let newRow = piece.position.row + direction.0
            let newCol = piece.position.col + direction.1
            
            if isValid(row: newRow, col: newCol) {
                if let targetPiece = getPiece(at: newRow, col: newCol) {
                    if targetPiece.color != piece.color {
                        moves.insert(Position(row: newRow, col: newCol))
                    }
                } else {
                    moves.insert(Position(row: newRow, col: newCol))
                }
            }
        }
        
        return moves
    }
    
    private func calculateLinearMoves(from piece: ChessPiece, direction: (Int, Int)) -> Set<Position> {
        var moves: Set<Position> = []
        var currentRow = piece.position.row + direction.0
        var currentCol = piece.position.col + direction.1
        
        while isValid(row: currentRow, col: currentCol) {
            if let targetPiece = getPiece(at: currentRow, col: currentCol) {
                // Can capture enemy piece
                if targetPiece.color != piece.color {
                    moves.insert(Position(row: currentRow, col: currentCol))
                }
                break // Can't move past any piece
            }
            
            moves.insert(Position(row: currentRow, col: currentCol))
            currentRow += direction.0
            currentCol += direction.1
        }
        
        return moves
    }
}
