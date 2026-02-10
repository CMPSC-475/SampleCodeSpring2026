//
//  AroundTownApp.swift
//  AroundTown
//
//  Created by Nader Alfares on 2/7/26.
//

import SwiftUI

@main
struct AroundTownApp: App {
    @State var locationManager : LocationManager = LocationManager()
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(locationManager)
        }
    }
}
