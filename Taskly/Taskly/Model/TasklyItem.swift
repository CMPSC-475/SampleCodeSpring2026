//
//  TasklyItem.swift
//  Taskly
//
//  Created by Nader Alfares on 3/1/26.
//
import Foundation


struct TasklyItem: Identifiable, Codable {
    var id: String = UUID().uuidString
    var title: String = ""
    var description: String = ""
    var completed: Bool = false
    var ownerId: String = ""
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case description
        case completed
        case ownerId = "owner_id"
    }
}
