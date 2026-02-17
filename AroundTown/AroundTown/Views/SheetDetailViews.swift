//
//  DetailViews.swift
//  AroundTown
//
//  Created by Nader Alfares on 2/7/26.
//
import SwiftUI
import MapKit


struct LongSheetDetailView : View {
    let place : Place
    
    var body : some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Header with category icon and title
                HStack(alignment: .top, spacing: 16) {
                    // Category icon
                    ZStack {
                        Circle()
                            .fill(place.category.categoryColor.gradient)
                            .frame(width: 60, height: 60)
                        
                        Image(systemName: place.category.systemImageName)
                            .font(.system(size: 28, weight: .semibold))
                            .foregroundStyle(.white)
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(place.title)
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Text(place.category.rawValue)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    
                    Spacer()
                }
                .padding(.horizontal)
                
                Divider()
                
                // Description section
                VStack(alignment: .leading, spacing: 8) {
                    Label("About", systemImage: "info.circle")
                        .font(.headline)
                        .foregroundStyle(place.category.categoryColor)
                    
                    Text(place.description)
                        .font(.body)
                        .foregroundStyle(.primary)
                }
                .padding(.horizontal)
                
                // Address section
                VStack(alignment: .leading, spacing: 8) {
                    Label("Address", systemImage: "mappin.and.ellipse")
                        .font(.headline)
                        .foregroundStyle(place.category.categoryColor)
                    
                    Text(place.address)
                        .font(.body)
                        .foregroundStyle(.secondary)
                }
                .padding(.horizontal)
                
                // Action buttons
                HStack(spacing: 12) {
                    Button {
                        // Open in Maps
                    } label: {
                        Label("Directions", systemImage: "arrow.triangle.turn.up.right.circle.fill")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(place.category.categoryColor)
                    
                    Button {
                        // Call/Share/etc
                    } label: {
                        Label("Share", systemImage: "square.and.arrow.up")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.bordered)
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .padding(.top)
        }
    }

}


struct FractionSheetDetailView : View {
    let place : Place
    @Environment(LocationManager.self) var manager
    
    
    private let transportTypes : [MKDirectionsTransportType] = [.walking, .automobile, .cycling, .transit]
    
    var body : some View {
        VStack(spacing: 16) {
            // Drag indicator
            Capsule()
                .fill(.secondary.opacity(0.5))
                .frame(width: 36, height: 5)
                .padding(.top, 8)
            
            // Header with icon and title
            HStack(spacing: 12) {
                // Category icon
                ZStack {
                    Circle()
                        .fill(place.category.categoryColor.gradient)
                        .frame(width: 50, height: 50)
                    
                    Image(systemName: place.category.systemImageName)
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundStyle(.white)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(place.title)
                        .font(.headline)
                        .fontWeight(.semibold)
                    
                    Text(place.category.rawValue)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                
                Spacer()
            }
            .padding(.horizontal)
            
            // Address
            HStack {
                Image(systemName: "mappin.circle.fill")
                    .foregroundStyle(.secondary)
                
                Text(place.address)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
                
                Spacer()
            }
            .padding(.horizontal)
            
            // Transport type buttons
            HStack(spacing: 12) {
                ForEach(transportTypes.enumerated(), id: \.offset) {_, type in
                    DirectionSheetButton(transportType: type, tint: place.category.categoryColor) {
//                        manager.provideDirections(for: place, type)
                    }
                }
            }
            .padding(.horizontal)
            
            Spacer()
        }
    }

}


struct DirectionSheetButton : View {
    var transportType : MKDirectionsTransportType
    var tint : Color
    var action : () -> Void

    private var imageName : String {
        switch transportType {
        case .automobile:
            return "car.fill"
        case .walking:
            return "figure.walk"
        case .transit:
            return "bus.fill"
        case .cycling:
            return "figure.outdoor.cycle"
        default:
            return "questionmark.circle"
        }
    }
    
    
    
    var body : some View {
        Button {
            action()
        } label: {
            Image(systemName: imageName)
                .font(.system(size: 15, weight: .semibold))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 8)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(tint)
                        .frame(width: 80, height: 50)
                )
                .foregroundStyle(.white)
        }

        
    }
}

private struct FractionSheetDetailView_PreviewContainer: View {
    @Environment(LocationManager.self) var manager
    @State private var selectedDetent: PresentationDetent = .fraction(0.3)
    
    @ViewBuilder
    func detailSheet(for place: Place) -> some View {
        switch selectedDetent {
        case .fraction(0.3):
            FractionSheetDetailView(place: place)
        case .large:
            LongSheetDetailView(place: place)
        default:
            Text("Error")
        }
    }
    
    var body: some View {
        Text("Map")
            .sheet(isPresented: .constant(true)) {
                detailSheet(for: manager.places.first!)
                    .presentationDetents([
                        .fraction(0.3),
                        .large
                    ], selection: $selectedDetent)
            }
    }
}


#Preview {
    FractionSheetDetailView_PreviewContainer()
        .environment(LocationManager())
}


struct DirectionDetailsView : View {
    @Environment(LocationManager.self) var manager : LocationManager
    
    var body : some View {
        //TODO: - display directions
    }
}


