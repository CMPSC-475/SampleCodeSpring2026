//
//  GameStats.swift
//  MindFlip
//
//  Created by Nader Alfares on 1/20/26.
//
import Foundation



struct StatEntry: Codable, Identifiable {
    var id: UUID = UUID()
    var name: String
    var gameDifficulty : GameDifficulty
    var missed: Int
    var correct: Int
    var time: Int // seconds
}


struct GameStats {
    var gameStats: [StatEntry] = []
    
    
    init() {
        loadFromJSON(filename: "usersStats")
    }

    var bestTime: Int? {
        gameStats.min(by: { $0.time < $1.time })?.time
    }

    mutating func addStat(name: String, gameDifficulty: GameDifficulty, missed: Int, correct: Int, time: Int) {
        gameStats.append(
            StatEntry(name: name, gameDifficulty:gameDifficulty, missed: missed, correct: correct, time: time)
        )
    }

    mutating func loadFromJSON(filename: String) {
        //TODO: Implement loading from JSON file either from main bundle or document directory
    }
    
    
    func save() {
        //TODO: Implement saving data to JSON in document directory
    }
}


