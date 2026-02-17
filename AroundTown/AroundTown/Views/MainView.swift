//
//  ContentView.swift
//  AroundTown
//
//  Created by Nader Alfares on 2/7/26.
//

import SwiftUI
import MapKit

struct MainView: View {
    @Environment(LocationManager.self) var locationManager : LocationManager
    
    
    private var trackUserButtonImage : String {
        "location"
    }

    var body: some View {
        @Bindable var manager = self.locationManager
        let searchToolbar = ToolbarItem(placement: .topBarLeading) {
            ToolbarMenuPicker(systemImage: "magnifyingglass", options: Category.allCases) { option in
                option.rawValue
            } onSelect: { option in
                manager.performSearch(on: option)
            }
        }
        
        let mapStyleToolbar = ToolbarItem(placement: .topBarTrailing) {
            ToolbarMenuPicker(systemImage: "map", options: MapStyleOption.allCases) { option in
                option.rawValue
            } onSelect: { option in
                manager.mapStyleOption = option
            }
        }
        let userlocationToolbar = ToolbarItem(placement: .bottomBar) {
            Button {
                //TODO: enable/disable user location
            } label: {
                Image(systemName: trackUserButtonImage)
            }
            
        }
        
        NavigationStack {
            DownTownMapView()
                .toolbar {
                    searchToolbar
                    mapStyleToolbar
                    userlocationToolbar
                }
        }
        
    }
}


fileprivate struct ToolbarMenuPicker<Option: Hashable>: View {
    let systemImage: String
    let options: [Option]
    let title: (Option) -> String
    let onSelect: (Option) -> Void

    var body: some View {
        Menu {
            ForEach(options, id: \.self) { option in
                Button {
                    onSelect(option)
                } label: {
                    Text(title(option))
                }
            }
        } label: {
            Image(systemName: systemImage)
        }
    }
}


#Preview {
    MainView()
        .environment(LocationManager())
}
