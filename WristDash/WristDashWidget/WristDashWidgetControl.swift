//
//  WristDashWidgetControl.swift
//  WristDashWidget
//
//  Created by Nader Alfares on 4/9/26.
//

import AppIntents
import SwiftUI
import WidgetKit

struct WristDashWidgetControl: ControlWidget {
    static let kind: String = "edu.psu.WristDash.WristDashWidget"

    var body: some ControlWidgetConfiguration {
        StaticControlConfiguration(kind: Self.kind) {
            ControlWidgetButton(action: RandomizeDashboardIntent()) {
                Label("Randomize", systemImage: "dice.fill")
            }
        }
        .displayName("Randomize Dashboard")
        .description("Randomize the dashboard widget with a random color, icon, number, and message.")
    }
}
