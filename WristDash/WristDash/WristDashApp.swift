//
//  WristDashApp.swift
//  WristDash
//
//  Created by Nader Alfares on 4/1/26.
//

import SwiftUI

@main
struct WristDashApp: App {
    @State var dashboardManager : DashboardManager = DashboardManager()
    @State var sessionManager : SessionManager = SessionManager()
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(dashboardManager)
                .environment(sessionManager)
        }
    }
}
