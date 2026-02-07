//
//  Color+random.swift
//  SnippetLab
//
//  Created by Nader Alfares on 2/4/26.
//
import SwiftUI


extension Color {
    static var random: Self {
        .init(hue: .random(in: 0..<1), saturation: 1, brightness: 1)
    }
}
