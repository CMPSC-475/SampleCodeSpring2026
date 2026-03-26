//
//  MainViewModel.swift
//  GeoCapture
//
//  Created by Nader Alfares on 3/24/26.
//

import Foundation
import MapKit
import UIKit

// MARK: - ViewModel
@MainActor
@Observable
class MapManager {
    var locationPins: [LocationPin] = []
    var selectedLocationPin: LocationPin?
    var showImagePicker = false
    var mapType: MKMapType = .standard
    var pendingCoordinate: CLLocationCoordinate2D?
    
    // Computed property for map types
    var availableMapTypes: [MKMapType] {
        [.standard, .hybrid, .satellite]
    }
    
    // MARK: - Actions
    func handleMapTap(at coordinate: CLLocationCoordinate2D) {
        // Store the coordinate and show image picker
        pendingCoordinate = coordinate
        showImagePicker = true
        
    }
    
    func addLocationPin(with image: UIImage?, at coordinate: CLLocationCoordinate2D) {
        let pin = LocationPin(coordinate: coordinate, image: image)
        locationPins.append(pin)
        pendingCoordinate = nil
    }
    
    func selectLocationPin(_ pin: LocationPin) {
        selectedLocationPin = pin
    }
    
    func dismissImagePicker() {
        showImagePicker = false
        pendingCoordinate = nil
    }
    
    func imageSelected(_ image: UIImage?) {
        guard let coordinate = pendingCoordinate else {
            print("No pending coordinate!")
            return
        }
        addLocationPin(with: image, at: coordinate)
        showImagePicker = false
    }
    
    func getAnnotations() -> [LocationAnnotation] {
        locationPins.map { LocationAnnotation(locationPin: $0) }
    }
}
