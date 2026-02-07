//
//  SnippetTopics.swift
//  SnippetLab
//
//  Created by Nader Alfares on 2/4/26.
//
import Foundation


struct Snippet : Identifiable, Codable {
    var id : String = UUID().uuidString
    var title : String = ""
    var summary : String?
    var sections : [SnippetSection] = []
    var tags : [String] = []
    
    /// The name of the demo view type (e.g., "PlacementDemoCode")
    /// This avoids importing SwiftUI in the model layer
    var demoViewTypeName : String?
    
    static var snippets : [Snippet] = [circlePostionSnippet, navigationStackSnippet]
}

struct SnippetSection : Identifiable, Codable {
    var id : String = UUID().uuidString
    var sectionTitle : String = ""
    var description : String = ""
    var codeBlock : String?
    
}



