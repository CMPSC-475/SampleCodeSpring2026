//
//  Category+Color.swift
//  AroundTown
//
//  Created by Nader Alfares on 2/7/26.
//
import SwiftUI

extension Category {
    var categoryColor: Color {
        switch self {
        case .coffee:
            return .brown
        case .restaurant, .dining, .pizza:
            return .orange
        case .bar:
            return .purple
        case .hotel:
            return .blue
        case .hospital:
            return .red
        case .shopping, .grocery:
            return .green
        case .parking:
            return .indigo
        case .gas:
            return .yellow
        case .library:
            return .teal
        case .movies:
            return .pink
        case .laundry:
            return .cyan
        case .airport:
            return .mint
        }
    }
}


extension Optional where Wrapped == Category {
    var categoryColor: Color {
        switch self {
        case .some(let category):
            return category.categoryColor
        case .none:
            return .red   // default color for nil
        }
    }
}
