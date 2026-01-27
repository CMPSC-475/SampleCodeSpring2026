//
//  SketchifyCoordinates.swift
//  Sketchify
//
//  Created by Nader Alfares on 1/26/26.
//
import Foundation


struct Point: Codable, Hashable {
    var x: Float = 0
    var y: Float = 0
}

struct BoundingBox: Hashable {
    var x: Float = 0
    var y: Float = 0
    var width: Float = 0
    var height: Float = 0
}

struct ColorComponents: Codable, Hashable {
    let red: Double
    let green: Double
    let blue: Double
    let alpha: Double

    init(red: Double = 0, green: Double = 0, blue: Double = 0, alpha: Double = 1.0) {
        self.red = red
        self.green = green
        self.blue = blue
        self.alpha = alpha
    }
}




