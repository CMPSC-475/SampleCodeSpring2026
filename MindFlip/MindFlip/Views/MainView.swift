//
//  ContentView.swift
//  MindFlip
//
//  Created by Nader Alfares on 1/13/26.
//

import SwiftUI

struct MainView: View {
    @Environment(GameViewModel.self) var manager : GameViewModel
    @State var showSettings : Bool = false
    
    // Computed properties for game stats
    private var matchedPairs: Int {
        manager.cards.filter { $0.isMatched }.count / 2
    }
    private var totalPairs: Int {
        manager.cards.count / 2
    }
    private var isGameComplete: Bool {
        matchedPairs == totalPairs && totalPairs > 0
    }
    
    
    
    var body: some View {
        ZStack {
            BackgroundColor.ignoresSafeArea()
            VStack {
                
                HeaderTitle()
                ScoreBoardView()
                CardsGrid()
                Spacer()
                TimerView()
                HStack {
                    NewGameButton()
                    SettingsButton(showSettingsSheet: $showSettings)
                    
                }
                .padding()

            }
            .padding()
            .sheet(isPresented: $showSettings) {
                SettingsSheetView()
            }
            
            if isGameComplete {
                CelebrationOverlayView()
            }
        }
    }
    
    
    let BackgroundColor : LinearGradient = LinearGradient(
        gradient: Gradient(colors: [
            Color(red: 0.10, green: 0.12, blue: 0.28),
            Color(red: 0.36, green: 0.24, blue: 0.66)
        ]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
}


struct SettingsButton : View {
    @Binding var showSettingsSheet: Bool
    var body: some View {
        Button {
            showSettingsSheet = true
        } label: {
            Image(systemName: "gear")
                .font(.title2)
                .foregroundColor(.white)
                .frame(width: 54, height: 54)
                .background(
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color(red: 0.4, green: 0.3, blue: 0.8),
                                    Color(red: 0.5, green: 0.4, blue: 0.9)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 4)
                )
        }
    }
}

struct ScoreBoardView : View {
    @Environment(GameViewModel.self) var manager : GameViewModel
    var body : some View {
        HStack {
            VStack {
                Text("Missed")
                    
                Text("\(manager.missed)")
            }
            .foregroundStyle(.white)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .fill(LinearGradient(colors: [.red, .yellow], startPoint: .top, endPoint: .bottom))
            )
            Spacer()
            VStack {
                Text("Correct")
                Text("\(manager.correct)")
                
            }
            .foregroundStyle(.white)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .fill(LinearGradient(colors: [.green, .cyan], startPoint: .top, endPoint: .bottom))
                )
        }
        .font(.system(size: 24, weight: .semibold, design: .rounded))
        .padding(.horizontal, 70)
        .padding(.vertical, 20)
    }
}



struct NewGameButton : View {
    @Environment(GameViewModel.self) var manager : GameViewModel
    var body: some View {
        Button {
            manager.startNewGame()
        } label: {
            HStack(spacing: 10) {
                Image(systemName: "arrow.counterclockwise.circle.fill")
                    .font(.title3)
                Text("New Game")
                    .font(.title3.bold())
            }
            .foregroundColor(Color(red: 0.3, green: 0.3, blue: 0.8))
            .frame(width: 200, height: 54)
            .background(
                Capsule()
                    .fill(.white)
                    .shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 4)
            )
        }
    }
}


struct HeaderTitle : View {
    
    var body : some View {
        Text("MindFlip")
            .font(.system(size: 48, weight: .black, design: .rounded))
            .foregroundStyle(
                LinearGradient(
                    colors: [.white, Color(white: 0.9)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .shadow(color: .black.opacity(0.3), radius: 4, x: 0, y: 2)
            .padding(.top, 20)
    }
}


struct CelebrationOverlayView : View {
    @Environment(GameViewModel.self) var gameViewModel : GameViewModel
    var body : some View {
        ZStack {
            Color.black.opacity(0.3)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("🎉")
                    .font(.system(size: 80))
                Text("All pairs matched!")
                    .font(.title2)
                    .foregroundColor(.white.opacity(0.9))
            
                
                Button {
                    gameViewModel.startNewGame()
                } label : {
                    HStack(spacing: 10) {
                        Text("Play Again!")
                            .font(.title3.bold())
                    }
                    .foregroundColor(Color(red: 0.3, green: 0.3, blue: 0.8))
                    .frame(width: 200, height: 54)
                    .background(
                        Capsule()
                            .fill(.white)
                            .shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 4)
                    )
                }
            }
            .padding(40)
            .background(
                RoundedRectangle(cornerRadius: 24)
                    .fill(.ultraThinMaterial)
            )
            .shadow(color: .black.opacity(0.3), radius: 20)
        }
        
    }
}




#Preview {
    MainView()
        .environment(GameViewModel())
}
