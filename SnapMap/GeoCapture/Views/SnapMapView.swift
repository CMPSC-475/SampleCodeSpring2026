//
//  GeoMap.swift
//  GeoCapture
//
//  Created by Nader Alfares on 3/24/26.
//
import SwiftUI
import UIKit
import MapKit




class Coordinator : NSObject, MKMapViewDelegate {
    
    let parent : SnapMapView
    
    init(_ parent: SnapMapView) {
        self.parent = parent
    }
    
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        guard let mapView = gesture.view as? MKMapView else { return }
        
        let point = gesture.location(in: mapView)
        let coordinate = mapView.convert(point, toCoordinateFrom: mapView)
        
        parent.onMapTap?(coordinate)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: any MKAnnotation) -> MKAnnotationView? {
        
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "LocationPin")
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "LocationPin")
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        <#code#>
    }
}




struct SnapMapView : UIViewRepresentable {
    
    var annotations: [LocationAnnotation]
    var mapType: MKMapType = .standard
    var onMapTap: ((CLLocationCoordinate2D) -> Void)?
    var onAnnotationTap: ((UUID) -> Void)?
    
    func makeCoordinator() ->  Coordinator{
        Coordinator(self)
    }
    
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        configureMapType(mapView)
        //TODO: Add tap gesture
        
        let gesture = UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleTap(_:)))
        
        mapView.addGestureRecognizer(gesture)
        
        return mapView
    }
    
    func updateUIView(_ mapView: MKMapView, context: Context) {
        configureMapType(mapView)
        //TODO: Update annotations
        let existingAnnotaions = mapView.annotations.compactMap( { $0 as? LocationAnnotation })
        let existingIDs = Set(existingAnnotaions.map {$0.id})
        let newIDs = Set(annotations.map {$0.id})
        
        //TODO: Remove annotations that no longer exist
        let toRemove = existingAnnotaions.filter { !newIDs.contains($0.id)}
        if !toRemove.isEmpty {
            mapView.removeAnnotations(toRemove)
        }
        
        
        //TODO: Add new annotations
        let toAdd = annotations.filter { !existingIDs.contains($0.id)}
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

