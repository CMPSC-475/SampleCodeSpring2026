//
//  ChessManager.swift
//  miniChess
//
//  Created by Nader Alfares on 2/2/26.
//
import SwiftUI

enum GameStatus {
    case inProgress
    case whiteWins
    case blackWins
    case stalemate
}

@Observable
class ChessManager {
    
    var chessBoard: ChessBoard = ChessBoard()
    var currentTurn: ChessColor = .white
    var selectedPiece: ChessPiece?
    var gameStatus: GameStatus = .inProgress
    var validMoves: Set<Position> = []
    
    // Drag state
    var draggedPiece: ChessPiece?
    var draggedPieceOriginalPosition: Position?
    
    // MARK: - Piece Selection
    func selectPiece(at row: Int, col: Int) {
        guard gameStatus == .inProgress else { return }
        
        let targetPosition = Position(row: row, col: col)
        
        // If we have a selected piece, try to move/capture
        if let selected = selectedPiece {
            // Check if this is a valid move (including captures)
            if validMoves.contains(targetPosition) {
                movePiece(selected, to: row, col: col)
                return
            }
        }
        
        // Check if there's a piece at this position to select
        if let piece = getPiece(at: row, col: col) {
            // Can only select pieces of the current player
            if piece.color == currentTurn {
                selectedPiece = piece
                validMoves = calculateValidMoves(for: piece)
            } else {
                // Clicked on enemy piece but no valid capture - deselect
                selectedPiece = nil
                validMoves = []
            }
        } else {
            // Clicked on empty square with no selected piece or invalid move - deselect
            selectedPiece = nil
            validMoves = []
        }
    }
    
    
    func selectPiece(_ piece: ChessPiece) {
        guard gameStatus == .inProgress else { return }
        let targetPosition = piece.position
        
        // If we have a selected piece, try to move/capture
        if let selected = selectedPiece {
            // Check if this is a valid move (including captures)
            if validMoves.contains(targetPosition) {
                movePiece(selected, to: targetPosition.row, col: targetPosition.col)
                return
            }
        }
        
        // Can only select pieces of the current player
        if piece.color == currentTurn {
            selectedPiece = piece
            validMoves = calculateValidMoves(for: piece)
        } else {
            // Clicked on enemy piece but no valid capture - deselect
            selectedPiece = nil
            validMoves = []
        }
        
    }
    

    private func movePiece(_ piece: ChessPiece, to row: Int, col: Int) {
        // Capture any piece at the destination
        if let capturedPiece = getPiece(at: row, col: col) {
            chessBoard.pieces.removeAll { $0.id == capturedPiece.id }
            
            // Check for king capture (win condition)
            if capturedPiece.type == .king {
                gameStatus = currentTurn == .white ? .whiteWins : .blackWins
            }
        }
        
        // Move the piece
        if let index = chessBoard.pieces.firstIndex(where: { $0.id == piece.id }) {
            chessBoard.pieces[index].position.row = row
            chessBoard.pieces[index].position.col = col
        }
        
        // Clear selection and switch turns
        selectedPiece = nil
        validMoves = []
        
        if gameStatus == .inProgress {
            currentTurn = currentTurn == .white ? .black : .white
        }
    }
    
    func getPiece(at row: Int, col: Int) -> ChessPiece? {
        chessBoard.pieces.first { $0.position.row == row && $0.position.col == col }
    }
    
    func isValid(row: Int, col: Int) -> Bool {
        row >= 0 && row < chessBoard.gridSize && col >= 0 && col < chessBoard.gridSize
    }
    
    func resetGame() {
        chessBoard = ChessBoard()
        currentTurn = .white
        selectedPiece = nil
        gameStatus = .inProgress
        validMoves = []
        draggedPiece = nil
        draggedPieceOriginalPosition = nil
    }
    
    // MARK: - Drag and Drop
    func startDrag(for piece: ChessPiece) {
        guard gameStatus == .inProgress else { return }
        guard piece.color == currentTurn else { return }
        
        draggedPiece = piece
        draggedPieceOriginalPosition = piece.position
        selectedPiece = piece
        validMoves = calculateValidMoves(for: piece)
    }
    
    func endDrag(at location: CGPoint, in geometry: GeometryProxy) {
        guard let draggedPiece = draggedPiece else { return }
        
        // Calculate which square the piece was dropped on
        let cellWidth = geometry.size.width / CGFloat(chessBoard.gridSize)
        let cellHeight = geometry.size.height / CGFloat(chessBoard.gridSize)
        
        let col = Int(location.x / cellWidth)
        let row = Int(location.y / cellHeight)
        
        let targetPosition = Position(row: row, col: col)
        
        // Check if this is a valid move
        if isValid(row: row, col: col) && validMoves.contains(targetPosition) {
            // Valid move - execute it
            movePiece(draggedPiece, to: row, col: col)
        } else {
            // Invalid move - piece will snap back automatically via position binding
            // Just clear selection
            selectedPiece = nil
            validMoves = []
        }
        
        // Clear drag state
        self.draggedPiece = nil
        self.draggedPieceOriginalPosition = nil
    }
    
    func cancelDrag() {
        draggedPiece = nil
        draggedPieceOriginalPosition = nil
        selectedPiece = nil
        validMoves = []
    }
}
