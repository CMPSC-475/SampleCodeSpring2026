//
//  TasklyApp.swift
//  Taskly
//
//  Created by Nader Alfares on 3/1/26.
//

import SwiftUI

@main
struct TasklyApp: App {
    @State var authManager = AuthManager()
    @State var networkManager = NetworkManager()
    
    var body: some Scene {
        WindowGroup {
            AuthContainerView()
                .environment(authManager)
                .environment(networkManager)
                .onAppear {
                    networkManager.configure(authManager: authManager)
                }
        }
    }
}
