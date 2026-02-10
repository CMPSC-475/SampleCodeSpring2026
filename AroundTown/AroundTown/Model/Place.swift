//
//  Place.swift
//  AroundTown
//
//  Created by Nader Alfares on 2/7/26.
//
import Foundation
import MapKit

struct Place: Identifiable, Codable {
    var id = UUID()
    var title : String
    var description : String
    var category : Category
    var address : String
    var latitude : Double
    var longitude : Double

    
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(UUID.self, forKey: .id) ?? UUID()
        self.title = try container.decode(String.self, forKey: .title)
        self.description = try container.decode(String.self, forKey: .description)
        self.category = try container.decode(Category.self, forKey: .category)
        self.address = try container.decode(String.self, forKey: .address)
        self.latitude = try container.decode(Double.self, forKey: .latitude)
        self.longitude = try container.decode(Double.self, forKey: .longitude)
    }
    
    
    init(title: String, description: String = "", category: Category, address: String = "", latitude : Double, longtitude : Double) {
        self.title = title
        self.description = description
        self.category = category
        self.address = address
        self.latitude = latitude
        self.longitude = longtitude
    }
    
    
    init(mapItem: MKMapItem, category: Category) {
        self.title = mapItem.name ?? "Unknown"
        self.description = category.rawValue
        self.category = category
        self.address = mapItem.address?.shortAddress ?? "Unknown Address"
        self.latitude = mapItem.location.coordinate.latitude as Double
        self.longitude = mapItem.location.coordinate.longitude as Double
    }
    
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: CLLocationDegrees(latitude), longitude: CLLocationDegrees(longitude))
    }

}

