//
//  GeoMap.swift
//  GeoCapture
//
//  Created by Nader Alfares on 3/24/26.
//
import SwiftUI
import UIKit
import MapKit

struct SnapMapView : UIViewRepresentable {
    
    var annotations: [LocationAnnotation]
    var mapType: MKMapType = .standard
    var onMapTap: ((CLLocationCoordinate2D) -> Void)?
    var onAnnotationTap: ((UUID) -> Void)?
    
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        configureMapType(mapView)
        //TODO: Add tap gesture
        return mapView
    }
    
    func updateUIView(_ mapView: MKMapView, context: Context) {
        configureMapType(mapView)
        //TODO: Update annotations
        
        
        //TODO: Remove annotations that no longer exist
        
        
        //TODO: Add new annotations
        
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

