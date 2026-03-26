//
//  GeoCaptureApp.swift
//  GeoCapture
//
//  Created by Nader Alfares on 3/24/26.
//

import SwiftUI

@main
struct GeoCaptureApp: App {
    @State var manager = MapManager()
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(manager)
        }
    }
}
