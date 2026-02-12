//
//  GecodeSample.swift
//  AroundTown
//
//  Created by Nader Alfares on 2/12/26.
//
import SwiftUI
import MapKit

struct GecodeSample: View {
    @Environment(LocationManager.self) var manager : LocationManager
    @State var oldMainLocation : CLLocation?
    @State var oldMainAddress : String?
    
    var body: some View {
        VStack {
            if let oldMainLocation {
                Text("\(oldMainLocation.coordinate.latitude), \(oldMainLocation.coordinate.longitude)")
            } else {
                ProgressView()
            }
            
            
            if let oldMainAddress {
                Text(oldMainAddress)
            } else {
                ProgressView()
            }
        }
        .onAppear {
            Task {
                oldMainLocation = try await manager.forwardGeocode(address: "Old Main, University Park, PA, 16801")
                oldMainAddress = try await manager.reverseGeocode(location: CLLocation(latitude: 40.792650, longitude: -77.859082))
                
            }
        }
            
    }
}

#Preview {
    GecodeSample()
        .environment(LocationManager())
}

