//
//  Category.swift
//  AroundTown
//
//  Created by Nader Alfares on 2/7/26.
//
import Foundation

enum Category : String, CaseIterable, Codable {
    case airport, bar, coffee, dining, gas = "Gas Station"
    case grocery, hospital, hotel, laundry, library, movies, parking, restaurant
    case pizza, shopping
    
    var systemImageName : String {
        switch self {
        case .airport:
            return "airplane"
        case .bar:
            return "wineglass"
        case .coffee:
            return "cup.and.saucer"
        case .dining:
            return "fork.knife"
        case .gas:
            return "fuelpump"
        case .grocery:
            return "cart"
        case .hospital:
            return "cross.case"
        case .hotel:
            return "bed.double"
        case .laundry:
            return "washer"
        case .library:
            return "books.vertical"
        case .movies:
            return "popcorn"
        case .parking:
            return "parkingsign.circle"
        case .restaurant:
            return "fork.knife.circle"
        case .pizza:
            return "circle.circle"
        case .shopping:
            return "bag"
        }
    }
    
}

