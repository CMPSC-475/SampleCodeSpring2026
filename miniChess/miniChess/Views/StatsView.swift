//
//  StatsView.swift
//  miniChess
//
//  Created by Nader Alfares on 2/3/26.
//
import SwiftUI

struct GameStatView : View {
    @Environment(ChessManager.self) var chessManager : ChessManager
    
    var body : some View {
        HStack(spacing: 40) {
            VStack(spacing: 4) {
                Image(systemName: "crown.fill")
                    .font(.title2)
                    .foregroundStyle(.white)
                Text("\(whitePieceCount)")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                Text("White")
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.7))
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white.opacity(0.1))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.white.opacity(0.2), lineWidth: 1)
                    )
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(chessManager.currentTurn == .white ? Color.white : Color.clear, lineWidth: 3)
            )
            
            VStack(spacing: 4) {
                Image(systemName: "crown.fill")
                    .font(.title2)
                    .foregroundStyle(.gray)
                Text("\(blackPieceCount)")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                Text("Black")
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.7))
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white.opacity(0.1))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.white.opacity(0.2), lineWidth: 1)
                    )
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(chessManager.currentTurn == .black ? Color.white : Color.clear, lineWidth: 3)
            )
        }
        
    }
    
    
    private var whitePieceCount: Int {
        chessManager.chessBoard.pieces.filter { $0.color == .white }.count
    }
    
    private var blackPieceCount: Int {
        chessManager.chessBoard.pieces.filter { $0.color == .black }.count
    }
}

