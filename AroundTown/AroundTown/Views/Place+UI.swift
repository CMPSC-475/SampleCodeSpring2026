//
//  Place+UI.swift
//  AroundTown
//
//  Created by Nader Alfares on 2/15/26.
//
import SwiftUI

extension Place {
    var categoryColor : Color {
        if let category = self.category {
            return category.categoryColor
        } else {
            return .red
        }
    }
    
    var systemImageName: String {
        if let category = self.category {
            return category.systemImageName
        } else {
            return "mappin.circle.fill"
        }
    }
    
    var categoryString : String {
        if let category = self.category {
            return category.rawValue
        } else {
            return "Dropped Pin"
        }
    }
}
