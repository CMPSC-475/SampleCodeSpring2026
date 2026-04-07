//
//  ContentView.swift
//  WristDash
//
//  Created by Nader Alfares on 4/1/26.
//

import SwiftUI

struct MainView: View {
    @Environment(DashboardManager.self) var dashboardManager : DashboardManager
    @Environment(SessionManager.self) var sessionManager: SessionManager
    var body: some View {
        @Bindable var dsMngr = dashboardManager
        @Bindable var sMngr = sessionManager
        NavigationStack {
            Form {
                NumberSliderSection()
                ColorGridPicker()
                IconGridPicker()
                MessageFeild()

                Section {
                    Button("Send to Watch") {
                        sessionManager.sendUpdate(number: Int(dashboardManager.selectedNumber), color: dashboardManager.selectedColor, iconName: dashboardManager.selectedIcon, message: dashboardManager.message)
                    }
                    .frame(maxWidth: .infinity)
                    .font(.headline)
                }
            }
            .navigationTitle("WristDash")
        }
    }
}

#Preview {
    MainView()
        .environment(DashboardManager())
        .environment(SessionManager())
}
