//
//  ContentView.swift
//  AroundTown
//
//  Created by Nader Alfares on 2/7/26.
//

import SwiftUI
import MapKit

struct MainView: View {
    @Environment(LocationManager.self) var locationManager : LocationManager

    var body: some View {
        DownTownMapView()
    }
    
}

#Preview {
    MainView()
        .environment(LocationManager())
}
