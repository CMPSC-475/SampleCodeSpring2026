//
//  CG+SketchifyGraphics.swift
//  Sketchify
//
//  Created by Nader Alfares on 1/26/26.
//
import SwiftUI


extension DrawingElement {
    var color : Color {
        Color(red: colorComponents.red, green: colorComponents.green, blue: colorComponents.blue, opacity: colorComponents.alpha)
    }
}

extension Point {
    var cgPoint: CGPoint {
        CGPoint(x: CGFloat(self.x), y: CGFloat(self.y))
    }
}

extension Array<Point> {
    var cgPointsCollection: [CGPoint] {
        map { CGPoint(x: CGFloat($0.x), y: CGFloat($0.y)) }
    }
}

extension Array<CGPoint> {
    var pointsCollection: [Point] {
        map { Point(x: Float($0.x), y: Float($0.y)) }
    }
}

extension ColorComponents {
    var color : Color {
        Color(red: self.red, green: self.green, blue: self.blue, opacity: self.alpha)
    }
}

extension Color {
    var colorComponents: ColorComponents {
        let resolved = self.resolve(in: EnvironmentValues())
        return ColorComponents(
            red: Double(resolved.red),
            green: Double(resolved.green),
            blue: Double(resolved.blue),
            alpha: Double(resolved.opacity)
        )
    }
}

extension BoundingBox {
    var cgRect : CGRect {
        CGRect(x: CGFloat(self.x), y: CGFloat(self.y), width: CGFloat(self.width), height: CGFloat(self.height))
    }
}
