//
//  LocationManager.swift
//  AroundTown
//
//  Created by Nader Alfares on 2/7/26.
//
import SwiftUI
import MapKit



@Observable
class LocationManager {
    var places : [Place] = []
    //TODO: Implement the view model
    
    var region : MKCoordinateRegion = MKCoordinateRegion(center: TownData.initialCoordinate, span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
    
    var selectedPlace: Place?
    
    
    init() {
        loadFromJson()
    }
}
















