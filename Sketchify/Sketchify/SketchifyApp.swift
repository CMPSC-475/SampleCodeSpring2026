//
//  SketchifyApp.swift
//  Sketchify
//
//  Created by Nader Alfares on 1/26/26.
//

import SwiftUI

@main
struct SketchifyApp: App {
    @State var manager : SketchifyManager = SketchifyManager()
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(manager)
        }
    }
}
