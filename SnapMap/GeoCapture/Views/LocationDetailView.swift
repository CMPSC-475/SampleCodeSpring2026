//
//  LocationDetailView.swift
//  GeoCapture
//
//  Created by Nader Alfares on 3/25/26.
//
import SwiftUI
import UIKit
import MapKit


// MARK: - Location Detail View
struct LocationDetailView: View {
    let locationPin: LocationPin
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                if let image = locationPin.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 400)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                } else {
                    ContentUnavailableView(
                        "No Image",
                        systemImage: "photo.badge.exclamationmark",
                        description: Text("No image was selected for this location")
                    )
                }
                
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Label("Latitude", systemImage: "location.north.line")
                        Spacer()
                        Text(String(format: "%.6f", locationPin.coordinate.latitude))
                            .fontWeight(.medium)
                    }
                    
                    HStack {
                        Label("Longitude", systemImage: "location")
                        Spacer()
                        Text(String(format: "%.6f", locationPin.coordinate.longitude))
                            .fontWeight(.medium)
                    }
                    
                    HStack {
                        Label("Added", systemImage: "clock")
                        Spacer()
                        Text(locationPin.timestamp, style: .relative)
                            .fontWeight(.medium)
                    }
                }
                .padding()
                .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 12))
                
                Spacer()
            }
            .padding()
            .navigationTitle("Location Details")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}
