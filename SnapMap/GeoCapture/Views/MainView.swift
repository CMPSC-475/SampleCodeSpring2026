//
//  MainView.swift
//  GeoCapture
//
//  Created by Nader Alfares on 3/24/26.
//

import SwiftUI
import UIKit
import MapKit

// MARK: - View
struct MainView: View {
    @Environment(MapManager.self) var manager
    @State private var selectedImage: UIImage?
    
    var body: some View {
        @Bindable var manager = manager
        ZStack {
            // Map View usign MKMapView
            SnapMapView(
                annotations: manager.getAnnotations(),
                mapType: manager.mapType,
                onMapTap: { coordinate in
                    manager.handleMapTap(at: coordinate)
                },
                onAnnotationTap: { id in
                    if let pin = manager.locationPins.first(where: { $0.id == id }) {
                        manager.selectLocationPin(pin)
                    }
                }
            )
            
            MapControlOverlay()
            
            
        }
        .ignoresSafeArea()
        .sheet(isPresented: $manager.showImagePicker) {
            ImagePicker(
                selectedImage: $selectedImage,
                isPresented: $manager.showImagePicker,
                sourceType: .photoLibrary
            )
        }
        .onChange(of: selectedImage) { _, newValue in
            guard let image = newValue else { return }
            manager.imageSelected(image)
            selectedImage = nil
        }
        .sheet(item: $manager.selectedLocationPin) { pin in
            LocationDetailView(locationPin: pin)
        }
    }
}


#Preview {
    MainView()
        .environment(MapManager())
}
