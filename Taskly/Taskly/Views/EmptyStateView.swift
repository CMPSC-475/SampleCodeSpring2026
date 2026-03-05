//
//  EmptyStateView.swift
//  Taskly
//
//  Created by Nader Alfares on 3/5/26.
//

import SwiftUI

struct EmptyStateView: View {
    var body: some View {
        ScrollView {
                ContentUnavailableView {
                    Label("No Tasks", systemImage: "checklist")
                        .foregroundStyle(Color.pennStateBlue)
                } description: {
                    Text("Tap the + button to create your first task")
                        .foregroundStyle(.secondary)
                }
                .padding(.top, 250)
        }
    }
}

#Preview {
    EmptyStateView()
}
