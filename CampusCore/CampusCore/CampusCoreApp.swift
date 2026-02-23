//
//  CampusCoreApp.swift
//  CampusCore
//
//  Created by Nader Alfares on 2/21/26.
//

import SwiftUI
import SwiftData

@main
struct CampusCoreApp: App {
    // Use the shared preview container with mock data for development
    // In production, you'd create a persistent container instead
    var sharedModelContainer: ModelContainer = PreviewContainer.shared

    var body: some Scene {
        WindowGroup {
            MainView()
        }
        .modelContainer(sharedModelContainer)
    }
}
