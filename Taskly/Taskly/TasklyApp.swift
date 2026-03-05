//
//  TasklyApp.swift
//  Taskly
//
//  Created by Nader Alfares on 3/1/26.
//

import SwiftUI

@main
struct TasklyApp: App {
    @State var networkManager : NetworkManager = NetworkManager()
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(networkManager)
        }
    }
}
