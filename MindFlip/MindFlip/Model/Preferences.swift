//
//  Preferences.swift
//  MindFlip
//
//  Created by Nader Alfares on 1/20/26.
//
import Foundation

enum GameDifficulty: String, CaseIterable, Codable {
    case easy = "Easy"
    case medium = "Medium"
    case hard = "Hard"
    
    var rawValue : String {
        switch self {
        case .easy: return "Easy"
        case .medium: return "Medium"
        case .hard: return "Hard"
        }
    }
    
    // map difficulty to grid size
    var gridSize : Int {
        switch self {
        case .easy: return 2
        case .medium: return 4
        case .hard: return 6
        }
    }
    
}


struct Preferences {
    var difficulty : GameDifficulty = .easy
}
