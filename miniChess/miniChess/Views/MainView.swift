//
//  ContentView.swift
//  miniChess
//
//  Created by Nader Alfares on 2/2/26.
//

import SwiftUI

struct MainView : View {
    @Environment(ChessManager.self) var chessManager : ChessManager
    @State private var isGameBoardVisible = true
    
    var body : some View {
        ZStack {
            // Background gradient for atmosphere
            
            backgroundGradient.ignoresSafeArea()
            
            VStack(spacing: 30) {
                Spacer()
                    .frame(height: 20)
                
                // Header with enhanced styling
                HeaderView()
                    .padding(.horizontal)
                
                // Chess board with shadow and glow effects
                ChessGameBoardView()
                    .frame(width: 340, height: 340)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .scaleEffect(isGameBoardVisible ? 1.0 : 0.8)
                    .opacity(isGameBoardVisible ? 1.0 : 0.0)
                
                // Game stats
                GameStatView()
                .padding(.horizontal)
                
                //New Game Button
                NewGameButton()
                
                
                Spacer()
            }
        }
    }
    

    
    
    let backgroundGradient = LinearGradient(
        gradient: Gradient(colors: [
            Color(red: 0.15, green: 0.15, blue: 0.2),
            Color(red: 0.25, green: 0.2, blue: 0.3)
        ]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}



#Preview {
     MainView()
        .environment(ChessManager())
}
