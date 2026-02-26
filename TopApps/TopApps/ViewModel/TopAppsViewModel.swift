//
//  TopAppsViewModel.swift
//  TopApps
//
//  Created by Nader Alfares on 2/22/26.
//

import Foundation
import SwiftUI

enum NetworkError: LocalizedError {
    case invalidURL
    case invalidResponse
    case decodingError(Error)
    case serverError(Int)
    case unknown(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidResponse:
            return "Invalid response from server"
        case .decodingError(let error):
            return "Failed to decode data: \(error.localizedDescription)"
        case .serverError(let code):
            return "Server error with code: \(code)"
        case .unknown(let error):
            return "Unknown error: \(error.localizedDescription)"
        }
    }
}

@MainActor
@Observable
class TopAppsViewModel {
    
    // MARK: - Published Properties
    private(set) var apps: [AppEntry] = []
    private(set) var isLoading = false
    private(set) var errorMessage: String?

    
    // MARK: - Public Methods
    func loadApps() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let fetchedApps = try await self.fetchTopApps()
            apps = fetchedApps
        } catch {
            if let networkError = error as? NetworkError {
                errorMessage = networkError.errorDescription
            } else {
                errorMessage = error.localizedDescription
            }
        }
        
        isLoading = false
    }
    
    func refresh() async {
        await loadApps()
    }
    
    
    func fetchTopApps(limit: Int = 100) async throws -> [AppEntry] {
        let configuration = URLSessionConfiguration.default
        let urlSession = URLSession(configuration: configuration)
        let decoder = JSONDecoder()
        
        let urlString = "https://itunes.apple.com/us/rss/toppaidapplications/limit=\(limit)/json"
        
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await urlSession.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.serverError(httpResponse.statusCode)
        }
        
        do {
            let feedResponse = try decoder.decode(AppFeedResponse.self, from: data)
            return feedResponse.feed.entry
        } catch {
            throw NetworkError.decodingError(error)
        }
    }
}
