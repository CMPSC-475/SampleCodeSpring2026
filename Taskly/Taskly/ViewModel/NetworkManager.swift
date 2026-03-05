//
//  NetworkManager.swift
//  Taskly
//
//  Created by Nader Alfares on 3/1/26.
//
import Foundation
import SwiftUI

@Observable
class NetworkManager {
    
    var ipAddress: String = "http://localhost:8000"
    
    // MARK: - Get Tasks
    func getTasks() async throws -> [TasklyItem] {
        guard let url = URL(string: "\(ipAddress)/tasks") else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "accept")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.invalidResponse
        }
        
        let decoder = JSONDecoder()
        return try decoder.decode([TasklyItem].self, from: data)
    }
    
    // MARK: - Create Task
    
    func createTask(title: String, description: String) async throws -> TasklyItem {
        guard let url = URL(string: "\(ipAddress)/tasks") else {
            throw NetworkError.invalidURL
        }
        
        let taskID = UUID().uuidString
        let taskData : [String: Any] = [
            "id": taskID,
            "title": title,
            "description": description,
            "completed": false
        ]
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "accept")
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        
        request.httpBody = try JSONSerialization.data(withJSONObject: taskData, options: [])
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.invalidResponse
        }
        
        
        let decoder = JSONDecoder()
        let createdTask = try decoder.decode(TasklyItem.self, from: data)
        return createdTask
    }
    
    func deleteTask(taskId: String) async throws {
        //TODO: - implment deleting a task
        guard let url = URL(string: "\(ipAddress)/tasks") else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("*/*", forHTTPHeaderField: "accept")
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.invalidResponse
        }
        
        
        
    }
    
    // MARK: - Mark Task as Complete/Incomplete
    func markTaskAs(completed: Bool, taskId: String) async throws {
        // Determine the endpoint based on completed status
        let endpoint = completed ? "complete" : "incomplete"
        
        // Construct the URL
        guard let url = URL(string: "\(ipAddress)/tasks/\(taskId)/\(endpoint)") else {
            throw NetworkError.invalidURL
        }
        
        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("application/json", forHTTPHeaderField: "accept")
        
        // Perform the request
        let (_, response) = try await URLSession.shared.data(for: request)
        
        // Check the response
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.httpError(statusCode: httpResponse.statusCode)
        }
    }
    
    func updateTask(taskId: String, with updatedTask : TasklyItem) async throws {
        // Construct the URL
        guard let url = URL(string: "\(ipAddress)/tasks/\(taskId)") else {
            throw NetworkError.invalidURL
        }
        
        let taskData: [String: Any] = [
            "id": updatedTask.id,
            "title": updatedTask.title,
            "description": updatedTask.description,
            "completed": updatedTask.completed
        ]
        
        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Encode the body
        request.httpBody = try JSONSerialization.data(withJSONObject: taskData)
        
        // Perform the request
        let (_, response) = try await URLSession.shared.data(for: request)
        
        // Check the response
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.httpError(statusCode: httpResponse.statusCode)
        }
    }
    
    // MARK: - Delete Task
    

    

    
    // MARK: - Network Errors
    
    enum NetworkError: LocalizedError {
        case invalidURL
        case invalidResponse
        case httpError(statusCode: Int)
        
        var errorDescription: String? {
            switch self {
            case .invalidURL:
                return "The URL is invalid."
            case .invalidResponse:
                return "The server response was invalid."
            case .httpError(let statusCode):
                return "Request failed with status code: \(statusCode)"
            }
        }
    }
}
