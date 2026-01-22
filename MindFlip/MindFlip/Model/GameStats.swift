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
    
    private let filename = "userStats"
    
    
    init() {
        loadFromJSON(filename: filename)
    }

    var bestTime: Int? {
        gameStats.min(by: { $0.time < $1.time })?.time
    }

    mutating func addStat(name: String, gameDifficulty: GameDifficulty, missed: Int, correct: Int, time: Int) {
        gameStats.append(
            StatEntry(name: name, gameDifficulty:gameDifficulty, missed: missed, correct: correct, time: time)
        )
        self.save()
    }

    mutating func loadFromJSON(filename: String) {
        // First try to load from documents directory (user's saved data)
        if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = documentsDirectory.appendingPathComponent("\(filename).json")
            
            if FileManager.default.fileExists(atPath: fileURL.path) {
                do {
                    let data = try Data(contentsOf: fileURL)
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    gameStats = try decoder.decode([StatEntry].self, from: data)
                    print("Successfully loaded stats from: \(fileURL.path)")
                    return
                } catch {
                    print("Failed to load from documents: \(error)")
                }
            }
        }
        
        // Fallback: Try to load from bundle (initial data)
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
            print("JSON file not found in bundle, starting with empty stats")
            return
        }

        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            gameStats = try decoder.decode([StatEntry].self, from: data)
            print("Successfully loaded stats from bundle")
        } catch {
            print("Failed to load JSON: \(error)")
        }
        
    }
    
    
    func save() {
        
        let encoder = JSONEncoder()
        
        do {
            let data = try encoder.encode(gameStats)
            let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let fileURL = documentDirectory.appendingPathComponent(filename + ".json")
            
            try data.write(to: fileURL)
            
            
        } catch {
            print("Failed save json", error)
            
        }
    }
}


