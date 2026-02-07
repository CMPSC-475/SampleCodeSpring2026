//
//  NavigationStackDemoCode.swift
//  SnippetLab
//
//  Created by Nader Alfares on 2/7/26.
//

import SwiftUI

struct NavigationStackDemo: View, DemoView {
    @State private var path = NavigationPath()
    
    enum Destination: Hashable {
        case detail(id: Int)
        case settings
        case profile(name: String)
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                Section("Basic Navigation") {
                    NavigationLink("Simple Detail View") {
                        SampleDetailView()
                    }
                }
                
                Section("Programmatic Navigation") {
                    Button("Push Detail 1") {
                        path.append(Destination.detail(id: 1))
                    }
                    
                    Button("Push Detail 2") {
                        path.append(Destination.detail(id: 2))
                    }
                    
                    Button("Push Settings") {
                        path.append(Destination.settings)
                    }
                    
                    Button("Push Profile") {
                        path.append(Destination.profile(name: "Jane Doe"))
                    }
                }
            }
            .navigationTitle("Navigation Stack")
            .navigationDestination(for: Destination.self) { destination in
                switch destination {
                case .detail(let id):
                    DetailViewWithID(id: id, path: $path)
                case .settings:
                    SettingsView(path: $path)
                case .profile(let name):
                    ProfileView(name: name)
                }
            }
        }
    }
}

// MARK: - Supporting Views

struct SampleDetailView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "star.fill")
                .font(.system(size: 60))
                .foregroundStyle(.yellow)
            
            Text("This is a simple detail view")
                .font(.headline)
            
            Text("Using NavigationLink")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .navigationTitle("Detail")
    }
}

struct DetailViewWithID: View {
    let id: Int
    @Binding var path: NavigationPath
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "\(id).circle.fill")
                .font(.system(size: 80))
                .foregroundStyle(.blue)
            
            Text("Detail View #\(id)")
                .font(.title)
            
            Text("Programmatically navigated")
                .font(.subheadline)
                .foregroundStyle(.secondary)
            
            Button("Push Another Detail") {
                path.append(NavigationStackDemo.Destination.detail(id: id + 1))
            }
            .buttonStyle(.borderedProminent)
            
            Button("Pop to Root") {
                path.removeLast(path.count)
            }
            .buttonStyle(.bordered)
        }
        .navigationTitle("Detail \(id)")
    }
}

struct SettingsView: View {
    @Binding var path : NavigationPath
    var body: some View {
        Form {
            Section("General") {
                Button("Go to Profile") {
                    path.append(NavigationStackDemo.Destination.profile(name: "Jane Doe"))
                }
            }
        }
        .navigationTitle("Settings")
    }
}

struct ProfileView: View {
    let name: String
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "person.circle.fill")
                .font(.system(size: 100))
                .foregroundStyle(.purple)
            
            Text(name)
                .font(.largeTitle)
                .bold()
            
            Text("Profile View")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .navigationTitle("Profile")
    }
}

#Preview {
    NavigationStackDemo()
}
