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
        
        let data = DashboardData(
            number: Int.random(in: 0...100),
            colorName: colors.randomElement()!,
            iconName: icons.randomElement()!,
            message: messages.randomElement()!)
        
        data.save()
        
        WidgetCenter.shared.reloadAllTimelines()
        
        
        let constentState = WristDashWidgetAttributes.ContentState(
            number: data.number, colorName: data.colorName, iconName: data.iconName, message: data.message)
        
        for activity in Activity<WristDashWidgetAttributes>.activities{
            await activity.update(ActivityContent(state: constentState, staleDate: nil))
        }
        
        
        
        
        

        return .result()
    }
}
