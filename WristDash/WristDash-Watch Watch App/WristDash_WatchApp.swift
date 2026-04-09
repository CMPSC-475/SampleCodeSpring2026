//
//  WristDash_WatchApp.swift
//  WristDash-Watch Watch App
//
//  Created by Nader Alfares on 4/1/26.
//

import SwiftUI

@main
struct WristDash_Watch_Watch_AppApp: App {
    @State var sessionManager : SessionManager = SessionManager()
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(sessionManager)
        }
    }
}
