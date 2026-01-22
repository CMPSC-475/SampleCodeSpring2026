//
//  SettingsSheetView.swift
//  MindFlip
//
//  Created by Nader Alfares on 1/20/26.
//
import Foundation
import SwiftUI


fileprivate  let backgroundColor = LinearGradient(
    gradient: Gradient(colors: [
        Color(red: 0.10, green: 0.12, blue: 0.28),
        Color(red: 0.36, green: 0.24, blue: 0.66)
    ]),
    startPoint: .topLeading,
    endPoint: .bottomTrailing
)

struct SettingsSheetView: View {
    @Environment(GameViewModel.self) var manager: GameViewModel
    
    private let sheetTabsHeaders : [String] = ["Leaderboard", "Settings"]
    
    private enum SheetTabHeaders : String, CaseIterable, Identifiable {
        case leaderboard, settings
        var id : String {return rawValue}
    }
    
    
    @State private var selectedTab : SheetTabHeaders = .leaderboard
    
    private var sortedStats: [StatEntry] {
        manager.gameStats.gameStats.sorted { $0.time < $1.time }
    }
    
    
    
    var body: some View {
        ZStack {
            backgroundColor
                .ignoresSafeArea()
            
            
            VStack {
                
                Picker("Game Center", selection: $selectedTab) {
                    ForEach(SheetTabHeaders.allCases) { tabHeader in
                        Text(tabHeader.rawValue).tag(tabHeader)
                    }
                }
                .pickerStyle(.segmented)
                
                
                switch selectedTab {
                case .leaderboard:
                    LeaderBoardView(sortedStats: sortedStats)
                case .settings:
                    SettingsView()

                }
                
                
            }
            .padding()
            .background(backgroundColor)
            
            
        }

        
    }
    

}


struct SettingsView : View {
    @State var selectedDifficulty : GameDifficulty = .easy
    var body : some View {
        VStack(spacing: 20) {
            Text("Settings")
                .font(.system(size: 36, weight: .black, design: .rounded))
                .foregroundStyle(
                    LinearGradient(
                        colors: [.white, Color(white: 0.9)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .padding()
            
            Text("Select Difficulty")
                .font(.system(size: 20))
                .foregroundStyle(.white)
                
            Picker("Difficulty", selection: $selectedDifficulty) {
                ForEach(GameDifficulty.allCases) { diff in
                    Text(diff.rawValue.capitalized).tag(diff)
                }
            }
            .pickerStyle(.segmented)
            
            
            Button {
                //TODO: -
            } label: {
                HStack(spacing: 10) {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.title3)
                    Text("Apply Changes")
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
            Spacer()

        }
        .onAppear {
            //TODO: set selected difficulty from manager
        }

    }
}


struct LeaderBoardView : View {
    var sortedStats : [StatEntry]
    
    private func formatTime(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let secs = seconds % 60
        return String(format: "%02d:%02d", minutes, secs)
    }
    
    var body : some View {
        VStack {
            Text("Leaderboard")
                .font(.system(size: 36, weight: .black, design: .rounded))
                .foregroundStyle(
                    LinearGradient(
                        colors: [.white, Color(white: 0.9)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
            ScrollView {
                ForEach(Array(sortedStats.enumerated()), id: \.element.id) { index, stat in
                    LeaderboardRow(
                        rank: index + 1,
                        stat: stat,
                        formatTime: formatTime
                    )
                }
            }
        }
        .padding(.top, 20)
        
    }
}


struct LeaderboardRow: View {
    let rank: Int
    let stat: StatEntry
    let formatTime: (Int) -> String
    
    private var rankEmoji: String {
        switch rank {
        case 1: return "🥇"
        case 2: return "🥈"
        case 3: return "🥉"
        default: return "\(rank)."
        }
    }
    
    private var accuracy: Int {
        guard stat.correct + stat.missed > 0 else { return 0 }
        return Int(Double(stat.correct) / Double(stat.correct + stat.missed) * 100)
    }
    
    var body: some View {
        HStack(spacing: 12) {
            // Rank
            Text(rankEmoji)
                .font(.title2)
                .frame(width: 40)
            
            // Player Name and Difficulty
            VStack(alignment: .leading, spacing: 4) {
                Text(stat.name)
                    .font(.headline)
                    .foregroundColor(.white)
                
                HStack(spacing: 8) {
                    DifficultyBadge(difficulty: stat.gameDifficulty)
                }
            }
            
            Spacer()
            
            // Stats
            VStack(alignment: .trailing, spacing: 4) {
                HStack(spacing: 4) {
                    Image(systemName: "timer")
                        .font(.caption)
                    Text(formatTime(stat.time))
                        .font(.system(.body, design: .monospaced).bold())
                }
                .foregroundColor(.white)
                
                HStack(spacing: 8) {
                    HStack(spacing: 2) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.caption2)
                            .foregroundColor(.green)
                        Text("\(stat.correct)")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.7))
                    }
                    
                    HStack(spacing: 2) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.caption2)
                            .foregroundColor(.red)
                        Text("\(stat.missed)")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.7))
                    }
                    
                    Text("\(accuracy)%")
                        .font(.caption.bold())
                        .foregroundColor(accuracy >= 80 ? .green : accuracy >= 60 ? .yellow : .red)
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.ultraThinMaterial)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(rank <= 3 ? Color.yellow.opacity(0.5) : Color.clear, lineWidth: 2)
                )
        )
        .padding(.horizontal)
    }
}

struct DifficultyBadge: View {
    let difficulty: GameDifficulty
    
    private var badgeColor: Color {
        switch difficulty {
        case .easy: return .green
        case .medium: return .orange
        case .hard: return .red
        }
    }
    
    var body: some View {
        Text(difficulty.rawValue)
            .font(.caption2.bold())
            .foregroundColor(.white)
            .padding(.horizontal, 8)
            .padding(.vertical, 2)
            .background(
                Capsule()
                    .fill(badgeColor.opacity(0.8))
            )
    }
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
