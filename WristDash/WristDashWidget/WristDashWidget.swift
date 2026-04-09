//
//  WristDashWidget.swift
//  WristDashWidget
//
//  Created by Nader Alfares on 4/9/26.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), number: 50, colorName: "blue", iconName: "heart.fill", message: "Hello World")
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        //TODO: get current entry from JSON
        SimpleEntry(date: Date(), number: 50, colorName: "blue", iconName: "heart.fill", message: "Hello World")
    }

    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        //TODO: there is only one entry, current data in json
        let entry = SimpleEntry(date: Date(), number: 50, colorName: "blue", iconName: "heart.fill", message: "Hello World")
        return Timeline(entries: [entry], policy: .never)
    }


}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let number: Int
    let colorName: String
    let iconName: String
    let message: String
}

struct WristDashWidgetEntryView: View {
    var entry: Provider.Entry

    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: entry.iconName)
                .font(.system(size: 36))
                .foregroundStyle(color(from: entry.colorName))

            Text("\(entry.number)")
                .font(.system(size: 44, weight: .bold, design: .rounded))
                .foregroundStyle(color(from: entry.colorName))

            Text(entry.message)
                .font(.caption)
                .multilineTextAlignment(.center)
                .lineLimit(2)
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

struct WristDashWidget: Widget {
    let kind: String = "WristDashWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            WristDashWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
    }
}

