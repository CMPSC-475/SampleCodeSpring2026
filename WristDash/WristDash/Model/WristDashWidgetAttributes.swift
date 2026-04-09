//
//  WristDashWidgetAttributes.swift
//  WristDash
//
//  Created by Nader Alfares on 4/9/26.
//

import ActivityKit
import Foundation

struct WristDashWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        var number: Int
        var colorName: String
        var iconName: String
        var message: String
    }

    var name: String
}

struct DashboardData: Codable {
    var number: Int
    var colorName: String
    var iconName: String
    var message: String

    static let defaultData = DashboardData(number: 50, colorName: "blue", iconName: "heart.fill", message: "Hello World")

    static var fileURL: URL? {
        FileManager.default
            .containerURL(forSecurityApplicationGroupIdentifier: "group.edu.psu.wristDash")?
            .appendingPathComponent("dashboard.json")
    }

    static func load() -> DashboardData {
        guard let url = fileURL,
              let data = try? Data(contentsOf: url),
              let dashboard = try? JSONDecoder().decode(DashboardData.self, from: data) else {
            return defaultData
        }
        return dashboard
    }

    func save() {
        guard let url = Self.fileURL,
              let data = try? JSONEncoder().encode(self) else { return }
        try? data.write(to: url, options: .atomic)
    }
}
