//
//  TimerView.swift
//  MindFlip
//
//  Created by Nader Alfares on 1/22/26.
//

import SwiftUI


struct TimerView: View {
    @Environment(GameViewModel.self) var gameViewModel: GameViewModel
    
    private var formattedTime: String {
        let minutes = Int(gameViewModel.elapsedTime) / 60
        let seconds = Int(gameViewModel.elapsedTime) % 60
        let milliseconds = Int((gameViewModel.elapsedTime.truncatingRemainder(dividingBy: 1)) * 100)
        return String(format: "%02d:%02d.%02d", minutes, seconds, milliseconds)
    }
    
    var body: some View {
        TimelineView(.periodic(from: .now, by: 0.01)) { timeline in
            HStack(spacing: 8) {
                Image(systemName: "timer")
                    .font(.title3)
                Text(formattedTime)
                    .font(.system(size: 32, weight: .bold, design: .monospaced))
                    .contentTransition(.numericText())
            }
            .foregroundStyle(.white)
            .padding(.horizontal, 24)
            .padding(.vertical, 12)
            .background(
                Capsule()
                    .fill(
                        LinearGradient(
                            colors: [
                                Color(red: 0.4, green: 0.3, blue: 0.8),
                                Color(red: 0.5, green: 0.4, blue: 0.9)
                            ],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 4)
            )
            .onChange(of: timeline.date) { _, _ in
                gameViewModel.updateTimer()
            }
        }
    }
}

