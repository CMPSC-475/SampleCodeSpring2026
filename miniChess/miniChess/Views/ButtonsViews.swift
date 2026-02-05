//
//  ButtonsViews.swift
//  miniChess
//
//  Created by Nader Alfares on 2/3/26.
//
import SwiftUI


struct NewGameButton : View {
    @Environment(ChessManager.self) var chessManager : ChessManager
    
    @State var scale : CGFloat = 1.0
    
    var body : some View {
        Button {
            scale = 1.5
            chessManager.resetGame()
        } label: {
            HStack(spacing: 10) {
                Image(systemName: "arrow.clockwise.circle.fill")
                    .font(.title3)
                Text("New Game")
                    .fontWeight(.semibold)
            }
            .animation(.easeInOut, value: scale)
            
            .foregroundStyle(.white)
            .padding(.horizontal, 30)
            .padding(.vertical, 14)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 0.4, green: 0.3, blue: 0.8),
                        Color(red: 0.5, green: 0.2, blue: 0.7)
                    ]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .clipShape(Capsule())
            .shadow(color: Color(red: 0.4, green: 0.3, blue: 0.8).opacity(0.5), radius: 15, x: 0, y: 5)
            .overlay(
                Capsule()
                    .stroke(Color.white.opacity(0.3), lineWidth: 1)
            )
            .scaleEffect(scale)
            
        }
        .padding(.top, 10)
        
    }
}

