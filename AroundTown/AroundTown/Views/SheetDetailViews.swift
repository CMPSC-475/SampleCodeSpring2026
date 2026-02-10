//
//  SheetDetailViews.swift
//  AroundTown
//
//  Created by Nader Alfares on 2/10/26.
//

//
//  DetailViews.swift
//  AroundTown
//
//  Created by Nader Alfares on 2/7/26.
//
import SwiftUI


struct SheetHeaderView : View {
    let place : Place
    var body : some View {
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
    }
    
}

struct SheetSectionView : View {
    let place : Place
    let title : String
    let iconName: String
    var body : some View {
        // Description section
        VStack(alignment: .leading, spacing: 8) {
            Label(title, systemImage: iconName)
                .font(.headline)
                .foregroundStyle(place.category.categoryColor)
            
            Text(place.description)
                .font(.body)
                .foregroundStyle(.primary)
        }
        
    }
}


struct LongSheetDetailView : View {
    let place : Place
    
    var body : some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Header with category icon and title
                SheetHeaderView(place: place)
                
                Divider()
                
                // Description section
                SheetSectionView(place: place, title: "About", iconName: "info.circle")
                    .padding(.horizontal)
                
                // Address section
                SheetSectionView(place: place, title: "Address", iconName: "mappin.and.ellipse")
                    .padding(.horizontal)
                
                // Action buttons
                HStack(spacing: 12) {
                    Button {
                        //Get Directions
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
                    .buttonStyle(.borderedProminent)
                    .tint(place.category.categoryColor)
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .padding(.top)
        }
    }

}


struct ShortSheetDetailView : View {
    let place : Place
    
    var body : some View {
        VStack(spacing: 16) {
            // Drag indicator
            Capsule()
                .fill(.secondary.opacity(0.5))
                .frame(width: 36, height: 5)
                .padding(.top, 8)
            
            // Header with icon and title
            SheetHeaderView(place: place)
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
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }

}




