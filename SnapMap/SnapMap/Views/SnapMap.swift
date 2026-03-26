//
//  GeoMap.swift
//  GeoCapture
//
//  Created by Nader Alfares on 3/24/26.
//
import SwiftUI
import UIKit
import MapKit


class Coordinator: NSObject, MKMapViewDelegate {
    var parent: SnapMap
    
    init(_ parent: SnapMap) {
        self.parent = parent
    }
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        guard let mapView = gesture.view as? MKMapView else { return }
        
        let point = gesture.location(in: mapView)
        let coordinate = mapView.convert(point, toCoordinateFrom: mapView)
        
        // Notify parent of tap
        parent.onMapTap?(coordinate)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let locationAnnotation = annotation as? LocationAnnotation else {
            return nil
        }
        
        let identifier = "LocationPin"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            
            // Add a detail button
            let detailButton = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = detailButton
        } else {
            annotationView?.annotation = annotation
        }
        
        // Set custom image if available
        if let image = locationAnnotation.image {
            // Create a thumbnail for the pin
            let thumbnailSize = CGSize(width: 40, height: 40)
            let renderer = UIGraphicsImageRenderer(size: thumbnailSize)
            let thumbnail = renderer.image { context in
                // Draw with rounded corners
                let rect = CGRect(origin: .zero, size: thumbnailSize)
                let path = UIBezierPath(roundedRect: rect, cornerRadius: 8)
                path.addClip()
                image.draw(in: rect)
            }
            annotationView?.image = thumbnail
        } else {
            // Default pin image
            annotationView?.image = UIImage(systemName: "mappin.circle.fill")
            annotationView?.tintColor = .systemRed
        }
        
        return annotationView
    }
    
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let locationAnnotation = view.annotation as? LocationAnnotation else {
            return
        }
        
        // Notify parent of annotation selection
        parent.onAnnotationTap?(locationAnnotation.id)
    }
}


struct SnapMap : UIViewRepresentable {
    
    var annotations: [LocationAnnotation]
    var mapType: MKMapType = .standard
    var onMapTap: ((CLLocationCoordinate2D) -> Void)?
    var onAnnotationTap: ((UUID) -> Void)?
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        
        configureMapType(mapView)
        
        // Add tap gesture
        let gesture = UITapGestureRecognizer(
            target: context.coordinator,
            action: #selector(Coordinator.handleTap(_:))
        )
        mapView.addGestureRecognizer(gesture)
        
        mapView.delegate = context.coordinator
        return mapView
    }
    
    func updateUIView(_ mapView: MKMapView, context: Context) {
        configureMapType(mapView)
        
        // Update annotations
        let existingAnnotations = mapView.annotations.compactMap { $0 as? LocationAnnotation }
        let existingIDs = Set(existingAnnotations.map { $0.id })
        let newIDs = Set(annotations.map { $0.id })
        
        // Remove annotations that no longer exist
        let toRemove = existingAnnotations.filter { !newIDs.contains($0.id) }
        if !toRemove.isEmpty {
            mapView.removeAnnotations(toRemove)
        }
        
        // Add new annotations
        let toAdd = annotations.filter { !existingIDs.contains($0.id) }
        if !toAdd.isEmpty {
            mapView.addAnnotations(toAdd)
        }
    }
    
    private func configureMapType(_ mapView: MKMapView) {
        switch mapType {
        case .standard:
            mapView.preferredConfiguration = MKStandardMapConfiguration()
        case .hybrid:
            mapView.preferredConfiguration = MKHybridMapConfiguration()
        case .satellite:
            mapView.preferredConfiguration = MKImageryMapConfiguration()
        default:
            mapView.preferredConfiguration = MKStandardMapConfiguration()
        }
    }
}

