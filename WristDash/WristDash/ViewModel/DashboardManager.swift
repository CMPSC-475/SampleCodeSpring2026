//
//  DashboardManager.swift
//  WristDash
//
//  Created by Nader Alfares on 4/1/26.
//
import SwiftUI


@Observable
class DashboardManager {
    
    var selectedNumber : Double = 50
    var selectedColor : Color = .blue
    var selectedIcon : String = "heart.fill"
    var message : String = "Hello World"
    
    let colorOptions : [Color] = [.red, .blue, .green, .orange, .purple, .yellow]
    let iconOptions : [String] = ["star.fill", "heart.fill", "bolt.fill", "flame.fill", "leaf.fill", "globe"]
    
}
