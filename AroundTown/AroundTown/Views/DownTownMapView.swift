//
//  DownTownMapView.swift
//  AroundTown
//
//  Created by Nader Alfares on 2/7/26.
//
import SwiftUI
import MapKit

struct DownTownMapView: View {
    @Environment(LocationManager.self) var locationManager : LocationManager
    
    
    @State var selectedDetents : PresentationDetent = .fraction(0.3)
    
    @ViewBuilder
    var sheetDetailView : some View {
        if let selectedPlace = locationManager.selectedPlace {
            switch selectedDetents {
            case .fraction(0.3):
                ShortSheetDetailView(place: selectedPlace)
            case .large:
                LongSheetDetailView(place: selectedPlace)
            default:
                ShortSheetDetailView(place: selectedPlace)
            }
        }
    }
    
    
    
    
    var body: some View {
        
        @Bindable var locationManager = self.locationManager
        Map(position: $locationManager.cameraPosition) {
            
            ForEach(locationManager.places) { place in
                
                Annotation("",coordinate: place.coordinate) {
                    PlaceAnnotationView(place: place)
                        .environment(locationManager)
                        .onTapGesture {
                            locationManager.selectedPlace = place
                        }
                }
                
            }
            
            
            MapPolygon(coordinates: TownData.downtownCoordinates)
                .foregroundStyle(Color.blue.opacity(0.3))
            
        }
        .mapStyle(locationManager.mapStyleOption.mapStyle)
        .onMapCameraChange {context in
            locationManager.region = context.region
        }
        .sheet(item: $locationManager.selectedPlace) { place in
            
            sheetDetailView
                .presentationDetents([.fraction(0.3), .large], selection: $selectedDetents)
        }
    }
}



#Preview {
    DownTownMapView()
        .environment(LocationManager())
}
