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
        //TODO: - implement getting tasks from api endpoint
        return []
    }
    
    // MARK: - Create Task
    
    func createTask(title: String, description: String) async throws -> TasklyItem {
        //TODO: - implement sending created tasks to api endpoint
        return TasklyItem()
    }
    
    func deleteTask(taskId: String) async throws {
        //TODO: - implment deleting a task
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
