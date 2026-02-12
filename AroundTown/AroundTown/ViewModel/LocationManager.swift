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

    
    var region : MKCoordinateRegion = MKCoordinateRegion(center: TownData.initialCoordinate, span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
    
    var selectedPlace: Place?
    
    var mapStyleOption : MapStyleOption = .standard
    
    
    init() {
        loadFromJson()
    }
    
    
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

