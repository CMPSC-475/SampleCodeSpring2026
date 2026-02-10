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
    
    @State var cameraPosition : MapCameraPosition = .region(MKCoordinateRegion(center: TownData.initialCoordinate, span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)))
    
    
    @State var selectedDetents : PresentationDetent = .fraction(0.3)
    
    var body: some View {
        
        @Bindable var locationManager = self.locationManager
        Map(initialPosition: cameraPosition) {
            
            ForEach(locationManager.places) { place in
                
                Annotation("",coordinate: place.coordinate) {
                    Image(systemName: place.category.systemImageName)
                        .font(.system(size: 30))
                        .onTapGesture {
                            locationManager.selectedPlace = place
                        }
                }
                
                
            }
            
            
            MapPolygon(coordinates: TownData.downtownCoordinates)
                .foregroundStyle(Color.blue.opacity(0.3))
            
        }
        //.mapStyle(.imagery)
        .onMapCameraChange {context in
            locationManager.region = context.region
        }
        .sheet(item: $locationManager.selectedPlace) { place in
            
            Text(place.title)
            
                .presentationDetents([.fraction(0.3), .large], selection: $selectedDetents)
        }
    }
}



#Preview {
    DownTownMapView()
        .environment(LocationManager())
}
