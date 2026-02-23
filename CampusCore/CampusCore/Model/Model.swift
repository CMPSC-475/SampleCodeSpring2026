//
//  Model.swift
//  CampusCore
//
//  Created by Nader Alfares on 2/21/26.
//

import Foundation
import SwiftData

// MARK: - User Role
enum UserRole: String, Codable, CaseIterable, Equatable {
    case student
    case instructor
    case director
    
    var toString: String { rawValue }
}

// MARK: - User
@Model
class User: Identifiable {
    var id: UUID
    var name: String
    var email: String
    var roleRawValue : String
    
    var role: UserRole {
        UserRole(rawValue: roleRawValue) ?? .student
    }

    /// All enrollments where this user is the student.
    @Relationship(deleteRule: .cascade, inverse: \Enrollment.student)
    var enrollments: [Enrollment] = []

    /// All courses this user teaches (if they are an instructor/director).
    @Relationship(deleteRule: .nullify, inverse: \Course.instructor)
    var teachingCourses: [Course] = []

    init(
        id: UUID = UUID(),
        name: String,
        email: String,
        role: UserRole
    ) {
        self.id = id
        self.name = name
        self.email = email
        self.roleRawValue = role.rawValue
    }
}

// Convenience helpers
extension User {
    var isStudent: Bool { role == .student }
    var isInstructor: Bool { role == .instructor }
    var isDirector: Bool { role == .director }
}

// MARK: - Course

@Model
class Course {
    var id: UUID
    var code: String      // e.g., "CMPSC 475"
    var title: String     // e.g., "Application Development"
    var term: String      // e.g., "Fall 2026"

    /// The primary instructor for this course.
    var instructor: User?

    /// All student enrollments for this course.
    @Relationship(deleteRule: .cascade, inverse: \Enrollment.course)
    var enrollments: [Enrollment] = []

    init(
        id: UUID = UUID(),
        code: String,
        title: String,
        term: String,
        instructor: User? = nil
    ) {
        self.id = id
        self.code = code
        self.title = title
        self.term = term
        self.instructor = instructor
    }
}

// Convenience computed roster
extension Course {
    var students: [User] {
        enrollments.map { $0.student }
    }
}

// MARK: - Enrollment (Student ↔ Course join)
@Model
class Enrollment {
    var id: UUID
    var createdAt: Date

    /// The enrolled student (must have role == .student in your logic).
    var student: User

    /// The course the student is enrolled in.
    var course: Course

    init(
        id: UUID = UUID(),
        student: User,
        course: Course,
        createdAt: Date = .now
    ) {
        self.id = id
        self.student = student
        self.course = course
        self.createdAt = createdAt
    }
}

