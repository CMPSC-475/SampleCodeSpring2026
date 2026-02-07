//
//  DemoViewResolver.swift
//  SnippetLab
//
//  Created by Nader Alfares on 2/7/26.
//
import SwiftUI

/// Resolves demo view type names to actual SwiftUI views
struct DemoViewResolver {
    
    /// Registry of available demo views
    /// Add new demo views here as you create them
    private static let registry: [String: any DemoView.Type] = [
        "CirclePositionDemo": CirclePositionDemo.self,
        "NavigationStackDemo": NavigationStackDemo.self,
    ]
    
    /// Creates a view from a type name
    /// - Parameter typeName: The name of the view type
    /// - Returns: An AnyView wrapping the instantiated view, or nil if not found
    static func view(for typeName: String?) -> AnyView? {
        guard let typeName = typeName,
              let viewType = registry[typeName] else {
            return nil
        }
        
        return AnyView(viewType.init())
    }
}

/// Helper view that displays a demo view or a placeholder if not available
struct DemoViewContainer: View {
    let snippet: Snippet
    
    var body: some View {
        if let demoView = DemoViewResolver.view(for: snippet.demoViewTypeName) {
            demoView
        } else {
            ContentUnavailableView(
                "No Demo Available",
                systemImage: "play.slash",
                description: Text("This snippet doesn't have an associated demo view.")
            )
        }
    }
}
