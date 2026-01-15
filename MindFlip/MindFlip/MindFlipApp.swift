//
//  MindFlipApp.swift
//  MindFlip
//
//  Created by Nader Alfares on 1/13/26.
//

import SwiftUI

@main
struct MindFlipApp: App {
    @State var manager : GameViewModel = GameViewModel()
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(manager)
        }
    }
}
