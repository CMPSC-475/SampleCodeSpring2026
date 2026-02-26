//
//  MainView+HelperViews.swift
//  TopApps
//
//  Created by Nader Alfares on 2/23/26.
//
import SwiftUI


extension MainView {
    // MARK: - Loading View
    var loadingView: some View {
        VStack(spacing: 16) {
            ProgressView()
                .controlSize(.large)
            Text("Loading top apps...")
                .font(.system(size: 16))
                .foregroundStyle(.secondary)
        }
    }
    
    // MARK: - Error View
    func errorView(message: String) -> some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 48))
                .foregroundStyle(.red)
            
            Text("Error")
                .font(.system(size: 20, weight: .semibold))
            
            Text(message)
                .font(.system(size: 16))
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Button {
                Task {
                    await viewModel.refresh()
                }
            } label: {
                Label("Try Again", systemImage: "arrow.clockwise")
                    .font(.system(size: 16, weight: .semibold))
                    .padding(.horizontal, 24)
                    .padding(.vertical, 12)
                    .background(Color.blue)
                    .foregroundStyle(.white)
                    .clipShape(Capsule())
            }
        }
    }
    
    // MARK: - App List View
    var appListView: some View {
        List {
            ForEach(Array(filteredApps.enumerated()), id: \.element.id) { index, app in
                NavigationLink {
                    AppDetailView(app: app, rank: index + 1)
                } label: {
                    AppRowView(app: app, rank: index + 1)
                }
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 16))
            }
        }
        .listStyle(.plain)
        .overlay {
            if filteredApps.isEmpty && !searchText.isEmpty {
                ContentUnavailableView.search(text: searchText)
            }
        }
    }
}
