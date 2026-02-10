//
//  DownTownMapView.swift
//  AroundTown
//
//  Created by Nader Alfares on 2/7/26.
//
import SwiftUI
import MapKit

struct DownTownMapView: View {
    @Environment(LocationManager.self) var locationManager : LocationManager
    var body: some View {
        VStack(alignment: .leading) {
            Image(systemName: "map.circle.fill")
            Text("Downtown\nMap")
        }
        .font(.system(size: 70))
    }
}



#Preview {
    DownTownMapView()
        .environment(LocationManager())
}
