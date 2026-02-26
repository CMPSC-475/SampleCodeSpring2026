//
//  ContentView.swift
//  TopApps
//
//  Created by Nader Alfares on 2/22/26.
//

import SwiftUI

struct MainView: View {
    @Environment(TopAppsViewModel.self) var viewModel : TopAppsViewModel
    @State var searchText = ""
    
    var filteredApps: [AppEntry] {
        if searchText.isEmpty {
            return viewModel.apps
        }
        return viewModel.apps.filter { app in
            app.appName.localizedCaseInsensitiveContains(searchText) ||
            app.artistName.localizedCaseInsensitiveContains(searchText) ||
            app.categoryName.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading && viewModel.apps.isEmpty {
                    loadingView
                } else if let errorMessage = viewModel.errorMessage, viewModel.apps.isEmpty {
                    errorView(message: errorMessage)
                } else {
                    appListView
                }
            }
            .navigationTitle("Top Paid Apps")
            .task {
                await viewModel.loadApps()
            }
            .refreshable {
                await viewModel.refresh()
            }
        }
        .searchable(text: $searchText, prompt: "Search apps")
    }
    

}

#Preview {
    MainView()
        .environment(TopAppsViewModel())
}
