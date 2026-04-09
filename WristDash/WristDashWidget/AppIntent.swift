//
//  AppIntent.swift
//  WristDashWidget
//
//  Created by Nader Alfares on 4/9/26.
//

import WidgetKit
import AppIntents
import ActivityKit

struct ConfigurationAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource { "Configuration" }
    static var description: IntentDescription { "Configure the WristDash widget." }
}

struct RandomizeDashboardIntent: AppIntent {
    static let title: LocalizedStringResource = "Randomize Dashboard"

    func perform() async throws -> some IntentResult {
        let colors = ["red", "blue", "green", "orange", "purple", "yellow"]
        let icons = ["star.fill", "heart.fill", "bolt.fill", "flame.fill", "leaf.fill", "globe"]
        let messages = ["Go team!", "Looking good!", "Keep it up!", "Hello World", "Nice work!", "Stay strong!"]

        //TODO: update Widget and LiveActivity after this control intent is triggered

        return .result()
    }
}
