//
//  LocationManager.swift
//  AroundTown
//
//  Created by Nader Alfares on 2/7/26.
//
import SwiftUI
import MapKit



@Observable
class LocationManager: NSObject, CLLocationManagerDelegate {
    
    var places : [Place] = []
    var region : MKCoordinateRegion = TownData.region
    var cameraPosition : MapCameraPosition = .region(TownData.region)
    var selectedPlace: Place?
    var mapStyleOption : MapStyleOption = .standard
    
    var cllocationManager : CLLocationManager

    override init() {
        
        cllocationManager = CLLocationManager()
        super.init()
        loadFromJson()
        cllocationManager.delegate = self
        cllocationManager.desiredAccuracy = kCLLocationAccuracyBest
        
    }
    
    
    //MARK: Local Search
    func performSearch(on category: Category) {
        places.removeAll()
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = category.rawValue
        request.region = region
        let search = MKLocalSearch(request: request)
        search.start { response, error in
            guard error == nil else {return}
            let mapItems = response!.mapItems
            for item in mapItems {
                let place = Place(mapItem: item, category: category)
                self.places.append(place)
            }
        }
    }
}

