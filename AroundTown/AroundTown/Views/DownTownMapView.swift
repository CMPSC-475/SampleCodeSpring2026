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
    
    @State var droppedPin : Place?
    
    @ViewBuilder
    var sheetDetailView : some View {
        if let selectedPlace = locationManager.selectedPlace {
            switch selectedDetents {
            case .fraction(0.3):
                FractionSheetDetailView(place: selectedPlace)
            case .large:
                LongSheetDetailView(place: selectedPlace)
            default:
                FractionSheetDetailView(place: selectedPlace)
            }
        }
    }
    
    
    
    
    var body: some View {
        
        @Bindable var locationManager = self.locationManager
        GeometryReader { proxy in
            MapReader { reader in
                Map(position: $locationManager.cameraPosition) {
                    
                    // check if there is a droppedPin by the user
                    if let droppedPin = droppedPin {
                        Annotation("",coordinate: droppedPin.coordinate) {
                            PlaceAnnotationView(place: droppedPin)
                        }
                    }
                    
                    // check if directions were asked for and plot polylines
                    if let route = locationManager.route {
                        MapPolyline(route.polyline)
                            .stroke(.blue, lineWidth: 5)
                    }
                    
                    
                    
                    UserAnnotation()
                    
                    ForEach(locationManager.places) { place in
                        
                        Annotation("",coordinate: place.coordinate) {
                            PlaceAnnotationView(place: place)
                                .environment(locationManager)
                        }
                        
                    }
                    
                    
                    MapPolygon(coordinates: TownData.downtownCoordinates)
                        .foregroundStyle(Color.blue.opacity(0.3))
                    
                }
                .gesture (
                    LongPressGesture(minimumDuration: 0.5).sequenced(before: SpatialTapGesture()).onEnded { value in
                        if case .second(true, let spatialTap?) = value,
                           let coordinate = reader.convert(spatialTap.location, from: .local) {
                            withAnimation {
                                droppedPin = Place(title: "Dropped Pin", category: nil , latitude: coordinate.latitude, longtitude: coordinate.longitude)
                                locationManager.selectedPlace = droppedPin
                            }
                        }
                        
                    }
                    
                )
                .mapStyle(locationManager.mapStyleOption.mapStyle)
                .onMapCameraChange {context in
                    locationManager.region = context.region
                }
            }
        }
        .sheet(item: $locationManager.selectedPlace) { place in
            
            if let _ = locationManager.directions {
                DirectionDetailsView()
                    .presentationDetents([.fraction(0.3)], selection: $selectedDetents)
                
            }
            else {
                sheetDetailView
                    .presentationDetents([.fraction(0.3), .large], selection: $selectedDetents)
            }
        }
        
    }
}



#Preview {
    DownTownMapView()
        .environment(LocationManager())
}
