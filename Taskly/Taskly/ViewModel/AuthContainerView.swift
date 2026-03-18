//
//  AuthContainerView.swift
//  Taskly
//
//  Created by Nader Alfares on 3/16/26.
//

import SwiftUI

struct AuthContainerView: View {
    @Environment(AuthManager.self) private var authManager
    
    var body: some View {
        Group {
            //TODO: check if user is authenticated
            //if authManager.isAuthenticated {
            if true {
                MainView()
            } else {
                LoginView()
            }
        }
    }
}

#Preview {
    AuthContainerView()
        .environment(AuthManager())
        .environment(NetworkManager())
}
