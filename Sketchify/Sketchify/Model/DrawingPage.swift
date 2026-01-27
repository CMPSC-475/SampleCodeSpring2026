//
//  DrawingPage.swift
//  Sketchify
//
//  Created by Nader Alfares on 1/26/26.
//
import Foundation

struct DrawingPage: Identifiable, Codable, Hashable {
    let id: UUID
    var title: String
    var elements: [DrawingElement]
    
    init(id: UUID = UUID(), title: String = "Untitled", elements: [DrawingElement] = []) {
        self.id = id
        self.title = title
        self.elements = elements
    }
}

