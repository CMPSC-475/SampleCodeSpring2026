//
//  ContentView.swift
//  WristDash-Watch Watch App
//
//  Created by Nader Alfares on 4/1/26.
//

import SwiftUI

struct MainView: View {
    @Environment(SessionManager.self) var sessionManager: SessionManager

    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: sessionManager.iconName)
                .font(.system(size: 40))
                .foregroundStyle(sessionManager.color)

            Text("\(sessionManager.number)")
                .font(.system(size: 48, weight: .bold, design: .rounded))
                .foregroundStyle(sessionManager.color)

            Text(sessionManager.message)
                .font(.caption)
                .multilineTextAlignment(.center)
                .lineLimit(2)
        }
    }
}

#Preview {
    let manager = SessionManager()
    manager.color = .red
    manager.iconName = "heart.fill"
    manager.message = "Go Red!"
    manager.number = 75
    return MainView()
        .environment(manager)
}
