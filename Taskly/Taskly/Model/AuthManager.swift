//
//  AuthManager.swift
//  Taskly
//
//  Created by Nader Alfares on 3/16/26.
//

import Foundation
import SwiftUI

@Observable
class AuthManager {
    
    // MARK: - Properties
    
    private(set) var isAuthenticated = false
    private(set) var accessToken: String?
    
    private let tokenKey = "taskly_access_token"
    
    // MARK: - Initialization
    
    init() {
        loadToken()
    }
    
    // MARK: - Public Methods
    
    func setToken(_ token: String) {
        self.accessToken = token
        self.isAuthenticated = true
        saveToken(token)
    }
    
    func logout() {
        self.accessToken = nil
        self.isAuthenticated = false
        deleteToken()
    }
    
    // MARK: - Private Methods
    
    private func saveToken(_ token: String) {
        UserDefaults.standard.set(token, forKey: tokenKey)
    }
    
    private func loadToken() {
        if let token = UserDefaults.standard.string(forKey: tokenKey) {
            self.accessToken = token
            self.isAuthenticated = true
        }
    }
    
    private func deleteToken() {
        UserDefaults.standard.removeObject(forKey: tokenKey)
    }
}
