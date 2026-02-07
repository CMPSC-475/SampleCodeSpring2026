//
//  SnippetLabApp.swift
//  SnippetLab
//
//  Created by Nader Alfares on 2/4/26.
//

import SwiftUI

@main
struct SnippetLabApp: App {
    @State var snippetManager : SnippetManager = SnippetManager()
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(snippetManager)
        }
    }
}
