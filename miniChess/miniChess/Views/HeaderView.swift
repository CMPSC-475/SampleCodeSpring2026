//
//  HeaderView.swift
//  miniChess
//
//  Created by Nader Alfares on 2/2/26.
//
import SwiftUI

struct HeaderView: View {
    @Environment(ChessManager.self) var chessManager : ChessManager
    
    var body : some View {
        VStack(spacing: 12) {
            // Main title or status
            HStack(spacing: 8) {
                if chessManager.gameStatus != .inProgress {
                    Image(systemName: statusIcon)
                        .font(.title)
                        .foregroundStyle(statusColor)
                }
                
                Text(statusText)
                    .font(.system(size: 32, weight: .bold, design: .rounded))
                    .foregroundStyle(
                        LinearGradient(
                            gradient: Gradient(colors: statusGradient),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
            }
            
            // Current turn indicator
            if chessManager.gameStatus == .inProgress {
                HStack(spacing: 8) {
                    Circle()
                        .fill(chessManager.currentTurn == .white ? Color.white : Color.gray)
                        .frame(width: 12, height: 12)
                        .overlay(
                            Circle()
                                .stroke(Color.white.opacity(0.5), lineWidth: 2)
                        )
                        .shadow(color: chessManager.currentTurn == .white ? .white : .gray, radius: 8)
                    
                    Text("\(chessManager.currentTurn.rawValue.capitalized)'s Turn")
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                        .foregroundStyle(.white)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 8)
                .background(
                    Capsule()
                        .fill(Color.white.opacity(0.15))
                        .overlay(
                            Capsule()
                                .stroke(Color.white.opacity(0.3), lineWidth: 1)
                        )
                )
            }
        }
        .padding()
    }
    
    private var statusText: String {
        switch chessManager.gameStatus {
        case .inProgress:
            return "MiniChess"
        case .whiteWins:
            return "White Wins!"
        case .blackWins:
            return "Black Wins!"
        case .stalemate:
            return "Stalemate"
        }
    }
    
    private var statusIcon: String {
        switch chessManager.gameStatus {
        case .whiteWins, .blackWins:
            return "trophy.fill"
        case .stalemate:
            return "hand.raised.fill"
        case .inProgress:
            return ""
        }
    }
    
    private var statusColor: Color {
        switch chessManager.gameStatus {
        case .whiteWins:
            return .yellow
        case .blackWins:
            return .yellow
        case .stalemate:
            return .orange
        case .inProgress:
            return .white
        }
    }
    
    private var statusGradient: [Color] {
        switch chessManager.gameStatus {
        case .inProgress:
            return [.white, Color(red: 0.8, green: 0.8, blue: 1.0)]
        case .whiteWins, .blackWins:
            return [.yellow, .orange]
        case .stalemate:
            return [.orange, .red]
        }
    }
}

