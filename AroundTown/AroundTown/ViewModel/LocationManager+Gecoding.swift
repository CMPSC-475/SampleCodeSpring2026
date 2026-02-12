//
//  LocationManager+Gecoding.swift
//  AroundTown
//
//  Created by Nader Alfares on 2/12/26.
//
import MapKit

extension LocationManager {
    
    func forwardGeocode(address: String) async throws -> CLLocation? {
        if let request = MKGeocodingRequest(addressString: address) {
            do {
                let mapItems = try await request.mapItems
                if let mapItem = mapItems.first {
                    return mapItem.location
                }
            } catch {
                // handle error
            }
        }
        return nil
    }
    
    func reverseGeocode(location: CLLocation) async throws -> String? {
        if let request = MKReverseGeocodingRequest(location: location) {
            do {
                let mapItems = try await request.mapItems
                if let mapItem = mapItems.first {
                    return mapItem.address?.fullAddress
                }
            } catch {
                // handle error
            }
        }
        return nil
    }
}
