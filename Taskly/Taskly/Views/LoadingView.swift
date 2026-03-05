//
//  LoadingView.swift
//  Taskly
//
//  Created by Nader Alfares on 3/5/26.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack(spacing: 16) {
            ProgressView()
                .scaleEffect(1.5)
                .tint(Color.pennStateBlue)
            Text("Loading tasks...")
                .foregroundStyle(Color.pennStateBlue)
                .font(.headline)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    LoadingView()
}
