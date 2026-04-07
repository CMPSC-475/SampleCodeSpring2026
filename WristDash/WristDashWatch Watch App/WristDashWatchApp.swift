//
//  WristDashWatchApp.swift
//  WristDashWatch Watch App
//
//  Created by Nader Alfares on 4/7/26.
//

import SwiftUI

@main
struct WristDashWatch_Watch_AppApp: App {
    @State var sessionManager : SessionManager = SessionManager()
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(sessionManager)
        }
    }
}
