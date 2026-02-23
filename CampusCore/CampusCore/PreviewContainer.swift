//
//  PreviewContainer.swift
//  CampusCore
//
//  Created by Nader Alfares on 2/21/26.
//

import SwiftData
import Foundation

/// Provides a configured ModelContainer with mock data for previews and testing
@MainActor
class PreviewContainer {
    
    /// Shared container instance with mock data
    static let shared: ModelContainer = {
        createContainer(withMockData: true)
    }()
    
    /// Creates a new container, optionally with mock data
    static func createContainer(withMockData: Bool = true) -> ModelContainer {
        let schema = Schema([
            User.self, 
            Course.self, 
            Enrollment.self
        ])
        
        let modelConfiguration = ModelConfiguration(
            schema: schema, 
            isStoredInMemoryOnly: true
        )
        
        do {
            let container = try ModelContainer(
                for: schema, 
                configurations: [modelConfiguration]
            )
            
            if withMockData {
                insertMockData(into: container)
            }
            
            return container
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }
    
    /// Inserts mock data into the provided container
    private static func insertMockData(into container: ModelContainer) {
        let context = container.mainContext
        
        // Create Students
        let student1 = User(
            name: "Alice Johnson",
            email: "alice@example.edu",
            role: .student
        )
        let student2 = User(
            name: "Bob Smith",
            email: "bob@example.edu",
            role: .student
        )
        let student3 = User(
            name: "Carol Martinez",
            email: "carol@example.edu",
            role: .student
        )
        
        // Create Instructors
        let instructor1 = User(
            name: "Dr. Emily Brown",
            email: "ebrown@example.edu",
            role: .instructor
        )
        let instructor2 = User(
            name: "Prof. David Lee",
            email: "dlee@example.edu",
            role: .instructor
        )
        
        // Create Directors
        let director1 = User(
            name: "Dr. Sarah Wilson",
            email: "swilson@example.edu",
            role: .director
        )
        
        // Insert users
        context.insert(student1)
        context.insert(student2)
        context.insert(student3)
        context.insert(instructor1)
        context.insert(instructor2)
        context.insert(director1)
        
        // Create Courses
        let course1 = Course(
            code: "CMPSC 475",
            title: "Application Development",
            term: "Spring 2026",
            instructor: instructor1
        )
        let course2 = Course(
            code: "CMPSC 345",
            title: "Data Structures",
            term: "Spring 2026",
            instructor: instructor2
        )
        let course3 = Course(
            code: "CMPSC 101",
            title: "Introduction to Computing",
            term: "Spring 2026",
            instructor: instructor1
        )
        
        context.insert(course1)
        context.insert(course2)
        context.insert(course3)
        
        // Create Enrollments
        let enrollment1 = Enrollment(student: student1, course: course1)
        let enrollment2 = Enrollment(student: student1, course: course2)
        let enrollment3 = Enrollment(student: student2, course: course1)
        let enrollment4 = Enrollment(student: student2, course: course3)
        let enrollment5 = Enrollment(student: student3, course: course2)
        let enrollment6 = Enrollment(student: student3, course: course3)
        
        context.insert(enrollment1)
        context.insert(enrollment2)
        context.insert(enrollment3)
        context.insert(enrollment4)
        context.insert(enrollment5)
        context.insert(enrollment6)
        
        // Save context
        do {
            try context.save()
        } catch {
            print("Failed to save mock data: \(error)")
        }
    }
}
