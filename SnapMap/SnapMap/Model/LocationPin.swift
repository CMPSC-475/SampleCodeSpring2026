//
//  LocationPin.swift
//  GeoCapture
//
//  Created by Nader Alfares on 3/24/26.
//

import Foundation
import MapKit
import UIKit

// MARK: - Model
struct LocationPin: Identifiable, Equatable {
    let id: UUID
    let coordinate: CLLocationCoordinate2D
    var image: UIImage?
    var timestamp: Date
    
    init(id: UUID = UUID(), coordinate: CLLocationCoordinate2D, image: UIImage? = nil, timestamp: Date = Date()) {
        self.id = id
        self.coordinate = coordinate
        self.image = image
        self.timestamp = timestamp
    }
    
    static func == (lhs: LocationPin, rhs: LocationPin) -> Bool {
        lhs.id == rhs.id
    }
}

// MARK: - Map Annotation
class LocationAnnotation: NSObject, MKAnnotation {
    let id: UUID
    let coordinate: CLLocationCoordinate2D
    let image: UIImage?
    var title: String?
    var subtitle: String?
    
    init(locationPin: LocationPin) {
        self.id = locationPin.id
        self.coordinate = locationPin.coordinate
        self.image = locationPin.image
        // Provide a default title/subtitle so MapKit callouts have content
        self.title = "Pinned Location"
        let lat = String(format: "%.5f", locationPin.coordinate.latitude)
        let lon = String(format: "%.5f", locationPin.coordinate.longitude)
        self.subtitle = "\(lat), \(lon)"
        super.init()
    }
}
