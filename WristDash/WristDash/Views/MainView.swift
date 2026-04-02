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
                        //TODO: send update to watch
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
