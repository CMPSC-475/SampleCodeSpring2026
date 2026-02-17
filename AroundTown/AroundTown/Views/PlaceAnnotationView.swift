//
//  PlaceAnnotationView.swift
//  AroundTown
//
//  Created by Nader Alfares on 2/10/26.
//
import SwiftUI


struct PlaceAnnotationView : View {
    @Environment(LocationManager.self) var manager : LocationManager
    let place: Place
    @State private var isExpanded = false
    
    var body: some View {
        VStack(spacing: 0) {
            // Main annotation bubble
            ZStack {
                // Background with shadow
                Circle()
                    .fill(.white)
                    .frame(width: 44, height: 44)
                    .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
                
                // Category icon with colored background
                ZStack {
                    Circle()
                        .fill(place.categoryColor.gradient)
                        .frame(width: 40, height: 40)
                    
                    Image(systemName: place.systemImageName)
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(.white)
                        .symbolEffect(.bounce, value: isExpanded)
                }
            }
            .onTapGesture {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                    manager.selectedPlace = place
                }
            }
        }
    }
}


#Preview {
    VStack {
        ForEach(Category.allCases, id:\.self) { cat in
            PlaceAnnotationView(place: Place(title: cat.rawValue, category: cat))
        }
    }
    .environment(LocationManager())
}
