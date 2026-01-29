//
//  DrawingElement.swift
//  Sketchify
//
//  Created by Nader Alfares on 1/26/26.
//
import Foundation


enum DrawingTool: String, Codable, Hashable {
    case circle
    case square
    case triangle
    case freeform
    
    var iconName: String {
        switch self {
        case .circle: return "circle"
        case .square: return "square"
        case .triangle: return "triangle"
        case .freeform: return "pencil.tip"
        }
    }
    
    var displayName: String {
        switch self {
        case .circle: return "Circle"
        case .square: return "Square"
        case .triangle: return "Triangle"
        case .freeform: return "Pen"
        }
    }
}

struct DrawingElement: Identifiable, Codable, Hashable {
    let id: UUID
    let tool: DrawingTool
    let points: [Point]
    let colorComponents: ColorComponents
    
    init(id: UUID = UUID(), tool: DrawingTool, points: [Point], color: ColorComponents = ColorComponents(), fillTargetTool: DrawingTool? = nil) {
        self.id = id
        self.tool = tool
        self.points = points
        self.colorComponents = color
    }
    
    var boundingRect: BoundingBox {
        guard points.count >= 1 else { return BoundingBox() }
        if tool == .freeform {
            let minX = points.map {$0.x}.min()!
            let minY = points.map {$0.y}.min()!
            let maxX = points.map {$0.x}.max()!
            let maxY = points.map {$0.y}.max()!
            return BoundingBox(x: minX, y: minY, width: maxX - minX, height: maxY - minY)
        }
        guard points.count >= 2 else { return BoundingBox() }
        let minX = min(points[0].x, points[1].x)
        let minY = min(points[0].y, points[1].y)
        let maxX = max(points[0].x, points[1].x)
        let maxY = max(points[0].y, points[1].y)
        return BoundingBox(x: minX, y: minY, width: maxX - minX, height: maxY - minY)
    }
}
