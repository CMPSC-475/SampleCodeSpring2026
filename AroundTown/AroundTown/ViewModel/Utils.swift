//
//  Utils.swift
//  AroundTown
//
//  Created by Nader Alfares on 2/10/26.
//
import Foundation
import SwiftUI
import MapKit


//define types for maps
enum MapStyleOption: String, CaseIterable, Hashable {
    case standard = "Standard"
    case hybrid = "Hybrid"
    case imagery = "Imagery"
    
    var mapStyle: MapStyle {
        switch self {
        case .standard:
            return .standard
        case .hybrid:
            return .hybrid
        case .imagery:
            return .imagery
        }
    }
}

// Data loadign from json
extension LocationManager {
    func loadFromJson() {
        let filename = "StateCollegePlaces"
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
            fatalError("Failed to locate \(filename) in bundle.")
        }
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(filename) from bundle.")
        }
        let decoder = JSONDecoder()
        do {
            places = try decoder.decode([Place].self, from: data)
        } catch {
            fatalError("Failed to decode \(filename) from bundle: \(error)")
        }
    }
}
