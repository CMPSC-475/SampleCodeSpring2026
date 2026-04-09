//
//  ContentView.swift
//  WristDash
//
//  Created by Nader Alfares on 4/1/26.
//

import SwiftUI
import ActivityKit
import WidgetKit

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
                    Button("Send to Watch!") {
                        sMngr.sendUpdate(number: Int(dsMngr.selectedNumber), color: dsMngr.selectedColor, iconName: dsMngr.selectedIcon, message: dsMngr.message)
                        startOrUpdateLiveActivity()
                        updateWidget()
                    }
                    .frame(maxWidth: .infinity)
                    .font(.headline)
                }
            }
            .navigationTitle("WristDash")
        }
    }

    private func startOrUpdateLiveActivity() {
        //TODO: Update Live Activity
    }

    private func updateWidget() {
        //TODO: Update Widget
    }
}

#Preview {
    MainView()
        .environment(DashboardManager())
        .environment(SessionManager())
}
