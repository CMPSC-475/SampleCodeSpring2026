//
//  ContentView.swift
//  SnippetLab
//
//  Created by Nader Alfares on 2/4/26.
//

import SwiftUI

struct MainView: View {
    @Environment(SnippetManager.self) var manager : SnippetManager
    var body: some View {
        NavigationStack {
            List(manager.snippets) { snippet in
                NavigationLink {
                    SnippetDetailView(snippet: snippet) {
                        DemoViewContainer(snippet: snippet)
                    }
                } label: {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(snippet.title)
                            .font(.headline)
                        if let summary = snippet.summary {
                            Text(summary)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                                .lineLimit(2)
                        }
                    }
                    .padding(.vertical, 4)
                }
            }
            .navigationTitle("Snippets")
        }
    }
}



#Preview {
    MainView()
        .environment(SnippetManager())
    
}
