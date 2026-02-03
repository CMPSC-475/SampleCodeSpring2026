//
//  ChessBoardView.swift
//  miniChess
//
//  Created by Nader Alfares on 2/2/26.
//
import SwiftUI


struct ChessGameBoardView : View {
    @Environment(ChessManager.self) var chessManager : ChessManager
    
    var body : some View {
        GeometryReader { geo in
            let cellWidth : CGFloat = geo.size.width / CGFloat(chessManager.chessBoard.gridSize)
            let cellHeight : CGFloat = geo.size.height / CGFloat(chessManager.chessBoard.gridSize)
            ZStack {
                BoardView(gridSize: chessManager.chessBoard.gridSize)
                
                
                // Highlight valid moves
                ForEach(Array(chessManager.validMoves), id: \.self) { position in
                    Circle()
                        .fill(Color.blue.opacity(0.4))
                        .frame(width: cellWidth * 0.4, height: cellHeight * 0.4)
                        .position(
                            x: cellWidth * CGFloat(position.col) + cellWidth / 2,
                            y: cellHeight * CGFloat(position.row) + cellHeight / 2
                        )
                }
                
                // Highlight selected piece (only when not dragging)
                if let selected = chessManager.selectedPiece, chessManager.draggedPiece == nil {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.blue, lineWidth: 4)
                        .frame(width: cellWidth, height: cellHeight)
                        .position(
                            x: cellWidth * CGFloat(selected.position.col) + cellWidth / 2,
                            y: cellHeight * CGFloat(selected.position.row) + cellHeight / 2
                        )
                }
                
                // Pieces (on top so they can be dragged)
                ForEach(chessManager.chessBoard.pieces, id: \.id) { piece in
                    PieceView(
                        piece: piece,
                        cellWidth: cellWidth,
                        cellHeight: cellHeight,
                        geometry: geo
                    )
                }
            }
        }
    }
    
}





private struct BoardView : View {
    @Environment(ChessManager.self) var chessManager : ChessManager
    var gridSize : Int
    var totalCells : Int {
        gridSize * gridSize
    }
    var body : some View {
        
        GeometryReader { geo in
            ZStack {
                ForEach(0..<totalCells, id: \.self) { i in
                    let row = i / gridSize
                    let col = i % gridSize
                    let isEvenSquare = (row + col) % 2 == 0
                    
                    Rectangle()
                        .fill(isEvenSquare ? Color.white : Color.black)
                        .frame(width: geo.size.width / CGFloat(gridSize), height: geo.size.height / CGFloat(gridSize))
                        .position(
                            x: CGFloat(col) * geo.size.width / CGFloat(gridSize) + geo.size.width / CGFloat(gridSize) / 2,
                            y: CGFloat(row) * geo.size.height / CGFloat(gridSize) + geo.size.height / CGFloat(gridSize) / 2
                        )
                        //TODO: add tap gesture
                }

                Grid(gridSize: self.gridSize)
                    .stroke(.black)
                
            }
        }
        
    }
    
}
