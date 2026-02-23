//
//  InstructorDashboardView.swift
//  CampusCore
//
//  Created by Nader Alfares on 2/21/26.
//
import SwiftUI
import SwiftData

struct InstructorDashboardView: View {
    /// The currently logged-in instructor
    var instructor: User
    
    @Environment(\.modelContext) private var modelContext
    
    @Query var teaching : [Course]
    
    init(instructor: User) {
        let instructorID = instructor.id
        let filter = #Predicate<Course> { c in
            c.instructor?.id == instructorID
        }
        _teaching = Query(filter: filter)
        self.instructor = instructor
    }
    
    var totalStudents: Int {
        teaching.reduce(0) { $0 + $1.students.count }
    }
    
    var body: some View {
        ZStack {
            Color.pennStateLightGray.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20) {
                    // User Header
                    PennStateDashboardHeader(user: instructor)
                        .padding(.top, 8)
                    
                    // Stats Card
                    HStack(spacing: 16) {
                        StatsCard(
                            title: "Teaching",
                            value: "\(teaching.count)",
                            systemImage: "book.fill",
                            color: .instructorAccent
                        )
                        
                        StatsCard(
                            title: "Students",
                            value: "\(totalStudents)",
                            systemImage: "person.2.fill",
                            color: .pennStateBlue
                        )
                    }
                    .padding(.horizontal)
                    
                    // Courses Section
                    VStack(spacing: 12) {
                        PennStateSectionHeader(
                            "My Courses",
                            count: teaching.count,
                            systemImage: "book.closed.fill"
                        )
                        
                        if teaching.isEmpty {
                            PennStateEmptyState(
                                title: "No Courses Assigned",
                                systemImage: "book.closed",
                                description: "You haven't been assigned any courses yet. Contact your director for course assignments."
                            )
                            .frame(height: 300)
                        } else {
                            VStack(spacing: 10) {
                                ForEach(teaching) { course in
                                    NavigationLink {
                                        InstructorCourseDetailView(course: course)
                                    } label: {
                                        InstructorCourseCard(course: course)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding(.bottom, 20)
                }
            }
        }
        .navigationTitle("My Courses")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Instructor Course Card
struct InstructorCourseCard: View {
    let course: Course
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 6) {
                    Text(course.code)
                        .font(.headline.weight(.bold))
                        .foregroundStyle(Color.pennStateNavy)
                    
                    Text(course.title)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .lineLimit(2)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(Color.instructorAccent.opacity(0.5))
            }
            
            Divider()
            
            HStack(spacing: 12) {
                PennStateBadge(
                    text: course.term,
                    systemImage: "calendar",
                    color: .pennStateBlue
                )
                
                Spacer()
                
                PennStateBadge(
                    text: "\(course.students.count) enrolled",
                    systemImage: "person.2.fill",
                    color: .instructorAccent
                )
            }
        }
        .padding()
        .pennStateCard()
    }
}

// MARK: - Instructor Course Detail View
struct InstructorCourseDetailView: View {
    @Bindable var course: Course
    
    @Environment(\.modelContext) private var modelContext
    @State private var showingAddStudent = false
    
    var body: some View {
        ZStack {
            Color.pennStateLightGray.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20) {
                    // Course Info Card
                    VStack(alignment: .leading, spacing: 16) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(course.code)
                                .font(.title2.bold())
                                .foregroundStyle(Color.pennStateNavy)
                            
                            Text(course.title)
                                .font(.headline)
                                .foregroundStyle(.secondary)
                        }
                        
                        Divider()
                        
                        InfoRow(label: "Term", value: course.term, systemImage: "calendar")
                        
                        InfoRow(
                            label: "Enrolled",
                            value: "\(course.students.count) students",
                            systemImage: "person.2.fill"
                        )
                    }
                    .padding()
                    .pennStateCard()
                    .padding(.horizontal)
                    .padding(.top, 8)
                    
                    // Enrolled Students Section
                    VStack(spacing: 12) {
                        PennStateSectionHeader(
                            "Enrolled Students",
                            count: course.students.count,
                            systemImage: "person.2.fill"
                        )
                        
                        if course.students.isEmpty {
                            PennStateEmptyState(
                                title: "No Students Enrolled",
                                systemImage: "person.2.slash",
                                description: "No students have enrolled in this course yet.",
                                action: { showingAddStudent = true },
                                actionLabel: "Add Student"
                            )
                            .frame(height: 250)
                        } else {
                            VStack(spacing: 10) {
                                ForEach(course.students) { student in
                                    StudentListCard(
                                        student: student,
                                        onDelete: { deleteStudent(student) }
                                    )
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    
                    // Add Student Button
                    PennStateActionButton(
                        title: "Add Student",
                        systemImage: "person.badge.plus",
                        color: .instructorAccent
                    ) {
                        showingAddStudent = true
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                }
            }
        }
        .navigationTitle(course.code)
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showingAddStudent) {
            AddStudentToCourseView(course: course)
        }
    }
    
    private func deleteStudent(_ student: User) {
        if let enrollment = course.enrollments.first(where: { $0.student.id == student.id }) {
            modelContext.delete(enrollment)
        }
    }
}


// MARK: - Add Student to Course View
struct AddStudentToCourseView: View {
    let course: Course
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @Query(filter: #Predicate<User> { user in
        user.roleRawValue == "student"
    }, sort: [SortDescriptor<User>(\.name)]) var allStudents: [User]
    
    @State private var searchText = ""
    
    // Computed property to filter out already enrolled students
    var availableStudents: [User] {
        let enrolledIDs = Set(course.students.map { $0.id })
        let filtered = allStudents.filter { !enrolledIDs.contains($0.id) }
        
        if searchText.isEmpty {
            return filtered
        } else {
            return filtered.filter { student in
                student.name.localizedCaseInsensitiveContains(searchText) ||
                student.email.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.pennStateLightGray.ignoresSafeArea()
                
                if availableStudents.isEmpty {
                    PennStateEmptyState(
                        title: searchText.isEmpty ? "No Available Students" : "No Results",
                        systemImage: searchText.isEmpty ? "person.2.slash" : "magnifyingglass",
                        description: searchText.isEmpty ? "All students are already enrolled in this course." : "No students match your search."
                    )
                } else {
                    ScrollView {
                        VStack(spacing: 10) {
                            ForEach(availableStudents) { (student: User) in
                                Button {
                                    enrollStudent(student)
                                } label: {
                                    HStack(spacing: 14) {
                                        PennStateUserAvatar(name: student.name, role: UserRole.student, size: 48)
                                        
                                        VStack(alignment: .leading, spacing: 6) {
                                            Text(student.name)
                                                .font(.headline)
                                                .foregroundStyle(Color.pennStateNavy)
                                            
                                            Text(student.email)
                                                .font(.caption)
                                                .foregroundStyle(.secondary)
                                        }
                                        
                                        Spacer()
                                        
                                        Image(systemName: "plus.circle.fill")
                                            .font(.title2)
                                            .foregroundStyle(Color.instructorAccent)
                                    }
                                    .padding()
                                    .pennStateCard()
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding()
                    }
                }
            }
            .searchable(text: $searchText, prompt: "Search students")
            .navigationTitle("Add Student")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    private func enrollStudent(_ student: User) {
        let enrollment = Enrollment(student: student, course: course)
        modelContext.insert(enrollment)
        try? modelContext.save()
    }
}
// MARK: - Previews
#Preview("Instructor Dashboard - With Courses") {
    NavigationStack {
        let container = PreviewContainer.shared
        let context = container.mainContext
        
        // Get an instructor with courses
        let instructors = try! context.fetch(FetchDescriptor<User>(
            predicate: #Predicate<User> { user in
                user.roleRawValue == "instructor"
            }
        ))
        
        let instructor = instructors.first ?? User(
            name: "Prof. John Smith",
            email: "jsmith@example.edu",
            role: .instructor
        )
        
        InstructorDashboardView(instructor: instructor)
            .modelContainer(container)
    }
}

#Preview("Instructor Dashboard - No Courses") {
    InstructorDashboardView(instructor: User(
        name: "Prof. Jane Doe",
        email: "jdoe@example.edu",
        role: .instructor
    ))
    .modelContainer(PreviewContainer.shared)
}

#Preview("Instructor Course Detail") {
    let container = PreviewContainer.shared
    let context = container.mainContext
    
    let course = try! context.fetch(FetchDescriptor<Course>()).first!
    
    return NavigationStack {
        InstructorCourseDetailView(course: course)
    }
    .modelContainer(container)
}

