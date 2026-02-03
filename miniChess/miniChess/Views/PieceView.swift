//
//  PieceView.swift
//  miniChess
//
//  Created by Nader Alfares on 2/2/26.
//
import SwiftUI


struct PieceView: View {
    @Environment(ChessManager.self) var chessManager : ChessManager
    let piece: ChessPiece
    let cellWidth: CGFloat
    let cellHeight: CGFloat
    let geometry: GeometryProxy
    
    @State private var dragOffset: CGSize = .zero
    @State private var isDragging = false
    
    
    var pieceColor : Color {
        piece.color == .white ? Color.white : Color.gray
    }
    
    @ViewBuilder
    private func pieceView(for type: ChessPieceType) -> some View {
        switch type {
        case .pawn:   PawnShape().stroke(.black).fill(pieceColor)
        case .bishop: BishopShape().stroke(.black).fill(pieceColor)
        case .rook:   RookShape().stroke(.black).fill(pieceColor)
        case .knight: KnightShape().stroke(.black).fill(pieceColor)
        case .king:   KingShape().stroke(.black).fill(pieceColor)
        case .queen:  QueenShape().stroke(.black).fill(pieceColor)
        }
    }
    
    
    var body: some View {
        //TODO: Implement Gestures
        pieceView(for: piece.type)
            .padding(5)
            .frame(width: cellWidth, height: cellHeight)
            .scaleEffect(isDragging ? 1.2 : 1.0)
            .opacity(isDragging ? 0.8 : 1.0)
            .shadow(color: .black.opacity(isDragging ? 0.4 : 0), radius: isDragging ? 10 : 0)
            .offset(dragOffset)
            .position(
                x: cellWidth * CGFloat(piece.position.col) + cellWidth / 2,
                y: cellHeight * CGFloat(piece.position.row) + cellHeight / 2
            )
            .foregroundStyle(piece.color == .white ? Color.white : Color.black)
//            .gesture(combinedGesture)
//            .zIndex(isDragging ? 100 : 0)
    }
}


