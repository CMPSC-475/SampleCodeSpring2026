//
//  TopAppsApp.swift
//  TopApps
//
//  Created by Nader Alfares on 2/22/26.
//

import SwiftUI

@main
struct TopAppsApp: App {
    @State var viewModel = TopAppsViewModel()
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(viewModel)
        }
    }
}
