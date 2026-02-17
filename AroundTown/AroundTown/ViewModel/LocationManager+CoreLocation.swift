//
//  LocationManager+CoreLocation.swift
//  AroundTown
//
//  Created by Nader Alfares on 2/17/26.
//
import MapKit


extension LocationManager {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            cllocationManager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            cllocationManager.startUpdatingLocation()
        default:
            cllocationManager.stopUpdatingLocation()
        }
    }
    
    
    
}

