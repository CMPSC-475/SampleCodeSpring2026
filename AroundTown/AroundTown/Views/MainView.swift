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

    var body: some View {
        @Bindable var manager = self.locationManager
        let searchToolbar = ToolbarItem(placement: .topBarLeading) {
            Menu {
                ForEach(Category.allCases, id:\.self) { cat in
                    Button {
                        manager.performSearch(on: cat)
                    } label : {
                        Text(cat.rawValue)
                    }
                }
            } label : {
                Image(systemName: "magnifyingglass")
            }
        }
        
        let mapStyleToolbar = ToolbarItem(placement: .bottomBar) {
            Picker("Map Style", selection: $manager.mapStyleOption) {
                ForEach(MapStyleOption.allCases, id: \.self)  {option in
                    Text(option.rawValue).tag(option)
                }
                
            }
            .pickerStyle(.segmented)
        }
        
        NavigationStack {
            DownTownMapView()
                .toolbar {
                    searchToolbar
                    mapStyleToolbar
                }
        }
        
    }
    
}

#Preview {
    MainView()
        .environment(LocationManager())
}
