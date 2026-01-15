//
//  ContentView.swift
//  MindFlip
//
//  Created by Nader Alfares on 1/13/26.
//

import SwiftUI

struct MainView: View {
    @Environment(GameViewModel.self) var manager : GameViewModel
    
    var body: some View {
        ZStack {
            BackgroundColor.ignoresSafeArea()
            VStack {
                
                HeaderTitle()
                ScoreBoardView()
                CardsGrid()
                Spacer()
                NewGameButton()

            }
            .padding()
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

struct ScoreBoardView : View {
    var body : some View {
        HStack {
            VStack {
                Text("Missed")
                    
                Text("0")
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
                Text("0")
                
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
    var body: some View {
        Button {
            //TODO
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
        .padding(.bottom, 30)
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


#Preview {
    MainView()
        .environment(GameViewModel())
}
