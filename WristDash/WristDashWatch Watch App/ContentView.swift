//
//  ContentView.swift
//  WristDashWatch Watch App
//
//  Created by Nader Alfares on 4/7/26.
//

import SwiftUI

struct MainView: View {
    @Environment(SessionManager.self) var sessionManager
    var body: some View {
        VStack {
            Image(systemName: sessionManager.iconName)
            Text(sessionManager.number.description)
            Text(sessionManager.message)
            
        }
        .foregroundStyle(sessionManager.color)
    }
}

#Preview {
    MainView()
        .environment(SessionManager())
    
}
