//
//  WristDashWidgetLiveActivity.swift
//  WristDashWidget
//
//  Created by Nader Alfares on 4/9/26.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct WristDashWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        var number: Int
        var colorName: String
        var iconName: String
        var message: String
    }

    var name: String
}

struct WristDashWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: WristDashWidgetAttributes.self) { context in
            // Lock screen/banner UI
            HStack(spacing: 16) {
                Image(systemName: context.state.iconName)
                    .font(.title)
                    .foregroundStyle(color(from: context.state.colorName))

                VStack(alignment: .leading) {
                    Text(context.state.message)
                        .font(.headline)
                    Text("\(context.state.number)")
                        .font(.largeTitle.bold())
                        .foregroundStyle(color(from: context.state.colorName))
                }

                Spacer()
            }
            .padding()
            .activityBackgroundTint(color(from: context.state.colorName).opacity(0.15))
            .activitySystemActionForegroundColor(.primary)

        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    Image(systemName: context.state.iconName)
                        .font(.title2)
                        .foregroundStyle(color(from: context.state.colorName))
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("\(context.state.number)")
                        .font(.title.bold())
                        .foregroundStyle(color(from: context.state.colorName))
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text(context.state.message)
                        .font(.body)
                }
            } compactLeading: {
                Image(systemName: context.state.iconName)
                    .foregroundStyle(color(from: context.state.colorName))
            } compactTrailing: {
                Text("\(context.state.number)")
                    .foregroundStyle(color(from: context.state.colorName))
            } minimal: {
                Image(systemName: context.state.iconName)
                    .foregroundStyle(color(from: context.state.colorName))
            }
        }
    }

    private func color(from name: String) -> Color {
        switch name {
        case "red": return .red
        case "blue": return .blue
        case "green": return .green
        case "orange": return .orange
        case "purple": return .purple
        case "yellow": return .yellow
        default: return .blue
        }
    }
}

extension WristDashWidgetAttributes {
    fileprivate static var preview: WristDashWidgetAttributes {
        WristDashWidgetAttributes(name: "WristDash")
    }
}

extension WristDashWidgetAttributes.ContentState {
    fileprivate static var sample: WristDashWidgetAttributes.ContentState {
        WristDashWidgetAttributes.ContentState(number: 75, colorName: "blue", iconName: "heart.fill", message: "Hello World")
    }

    fileprivate static var sampleAlt: WristDashWidgetAttributes.ContentState {
        WristDashWidgetAttributes.ContentState(number: 42, colorName: "orange", iconName: "star.fill", message: "Looking good!")
    }
}

#Preview("Notification", as: .content, using: WristDashWidgetAttributes.preview) {
   WristDashWidgetLiveActivity()
} contentStates: {
    WristDashWidgetAttributes.ContentState.sample
    WristDashWidgetAttributes.ContentState.sampleAlt
}
