//
//  PersistanceManager.swift
//  Sketchify
//
//  Created by Nader Alfares on 1/26/26.
//
import SwiftUI

class PersistenceManager {
    
    private let filename : String = "sketchifyDB.json"
    
    private var fileURL: URL {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return documentDirectory.appendingPathComponent(filename)
    }
    
    func savePages(_ pages: [DrawingPage]) {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            encoder.dateEncodingStrategy = .iso8601
            let data = try encoder.encode(pages)
            try data.write(to: fileURL)
        } catch {
            print("Error saving drawing pages: \(error.localizedDescription)")
        }
    }
    
    func loadPages() -> [DrawingPage] {
        guard FileManager.default.fileExists(atPath: fileURL.path) else {
            print("No existing drawing pages file found")
            return []
        }
        
        do {
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let pages = try decoder.decode([DrawingPage].self, from: data)
            return pages
        } catch {
            print("Error loading drawing pages: \(error.localizedDescription)")
            return []
        }
    }
    
    func deleteAllPages() {
        do {
            if FileManager.default.fileExists(atPath: fileURL.path) {
                try FileManager.default.removeItem(at: fileURL)
            }
        } catch {
            print("Error deleting drawing pages: \(error.localizedDescription)")
        }
    }
    
    
    
}
