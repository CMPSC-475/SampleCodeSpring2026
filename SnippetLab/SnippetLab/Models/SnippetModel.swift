//
//  SnippetTopics.swift
//  SnippetLab
//
//  Created by Nader Alfares on 2/4/26.
//
import Foundation


enum SnippetTopic: String, CaseIterable, Identifiable, Codable {
    case shapes

    var id: String { rawValue }
    var title: String {
        switch self {
        case .shapes : return "Shapes"
        }
    }
}



struct Snippet : Identifiable {
    var id : UUID = UUID()
    var title : String = ""
    var summary : String = ""
    var tags : [String] = []
    
}
