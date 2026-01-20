//
//  SettingsSheetView.swift
//  MindFlip
//
//  Created by Nader Alfares on 1/20/26.
//
import Foundation
import SwiftUI

//TODO: -

struct SettingsSheetView: View {
    @Environment(GameViewModel.self) var viewModel: GameViewModel
    
    var body: some View {
        ZStack {
            backgroundColor
                .ignoresSafeArea()
            Text("Settings View")
        }
        
    }
    
    let backgroundColor = LinearGradient(
        gradient: Gradient(colors: [
            Color(red: 0.10, green: 0.12, blue: 0.28),
            Color(red: 0.36, green: 0.24, blue: 0.66)
        ]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}

#Preview {
    VStack {
        EmptyView()
    }
        .sheet(isPresented: .constant(true)) {
            SettingsSheetView()
                .environment(GameViewModel())
        }
}
