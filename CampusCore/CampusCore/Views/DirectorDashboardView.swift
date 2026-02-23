//
//  DirectorDashboardView.swift
//  CampusCore
//
//  Created by Nader Alfares on 2/21/26.
//
import SwiftUI
import SwiftData

struct DirectorDashboardView: View {
    var director: User
    
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Course.code) private var allCourses: [Course]
    @Query(filter: #Predicate<User> { $0.roleRawValue == "student" }) private var allStudents: [User]
    @Query(filter: #Predicate<User> { $0.roleRawValue == "instructor" }) private var allInstructors: [User]
    
    @State private var showingAddCourse = false
    
    var totalEnrollments: Int {
        allCourses.reduce(0) { $0 + $1.students.count }
    }
    
    var body: some View {
        ZStack {
            Color.pennStateLightGray.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20) {
                    // User Header
                    PennStateDashboardHeader(user: director)
                        .padding(.top, 8)
                    
                    // Stats Grid
                    LazyVGrid(columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ], spacing: 16) {
                        StatsCard(
                            title: "Courses",
                            value: "\(allCourses.count)",
                            systemImage: "book.fill",
                            color: Color.directorAccent
                        )
                        
                        StatsCard(
                            title: "Students",
                            value: "\(allStudents.count)",
                            systemImage: "person.fill",
                            color: Color.studentAccent
                        )
                        
                        StatsCard(
                            title: "Instructors",
                            value: "\(allInstructors.count)",
                            systemImage: "person.fill.checkmark",
                            color: Color.instructorAccent
                        )
                        
                        StatsCard(
                            title: "Enrollments",
                            value: "\(totalEnrollments)",
                            systemImage: "person.2.fill",
                            color: Color.pennStateBlue
                        )
                    }
                    .padding(.horizontal)
                    
                    // Courses Section
                    VStack(spacing: 12) {
                        PennStateSectionHeader(
                            "All Courses",
                            count: allCourses.count,
                            systemImage: "books.vertical.fill"
                        )
                        
                        if allCourses.isEmpty {
                            PennStateEmptyState(
                                title: "No Courses",
                                systemImage: "book.closed",
                                description: "Create your first course to get started.",
                                action: { showingAddCourse = true },
                                actionLabel: "Add Course"
                            )
                            .frame(height: 300)
                        } else {
                            VStack(spacing: 10) {
                                ForEach(allCourses) { course in
                                    NavigationLink {
                                        CourseDetailView(course: course)
                                    } label: {
                                        DirectorCourseCard(course: course)
                                    }
                                    .buttonStyle(.plain)
                                    .contextMenu {
                                        Button(role: .destructive) {
                                            deleteCourse(course)
                                        } label: {
                                            Label("Delete Course", systemImage: "trash")
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    
                    // Add Course Button
                    PennStateActionButton(
                        title: "Add Course",
                        systemImage: "plus.circle.fill",
                        color: Color.directorAccent
                    ) {
                        showingAddCourse = true
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                }
            }
        }
        .navigationTitle("Director Dashboard")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showingAddCourse) {
            AddCourseView()
        }
    }
    
    private func deleteCourse(_ course: Course) {
        modelContext.delete(course)
    }
}

// MARK: - Director Course Card
struct DirectorCourseCard: View {
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
                    .foregroundStyle(Color.directorAccent.opacity(0.5))
            }
            
            Divider()
            
            HStack(spacing: 12) {
                PennStateBadge(
                    text: course.term,
                    systemImage: "calendar",
                    color: Color.pennStateBlue
                )
                
                if let instructor = course.instructor {
                    PennStateBadge(
                        text: instructor.name,
                        systemImage: "person.fill",
                        color: Color.instructorAccent
                    )
                } else {
                    PennStateBadge(
                        text: "No Instructor",
                        systemImage: "person.slash",
                        color: Color.orange
                    )
                }
                
                Spacer()
                
                PennStateBadge(
                    text: "\(course.students.count)",
                    systemImage: "person.2.fill",
                    color: Color.studentAccent
                )
            }
        }
        .padding()
        .pennStateCard()
    }
}

// MARK: - Add Course View
struct AddCourseView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var code = ""
    @State private var title = ""
    @State private var term = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Course Information") {
                    TextField("Course Code", text: $code)
                        .textInputAutocapitalization(.characters)
                    
                    TextField("Course Title", text: $title)
                    
                    TextField("Term", text: $term)
                        .textInputAutocapitalization(.words)
                }
            }
            .navigationTitle("New Course")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Create") {
                        createCourse()
                    }
                    .disabled(!isValid)
                }
            }
        }
    }
    
    private var isValid: Bool {
        !code.trimmingCharacters(in: .whitespaces).isEmpty &&
        !title.trimmingCharacters(in: .whitespaces).isEmpty &&
        !term.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    private func createCourse() {
        let newCourse = Course(
            code: code.trimmingCharacters(in: .whitespaces),
            title: title.trimmingCharacters(in: .whitespaces),
            term: term.trimmingCharacters(in: .whitespaces)
        )
        
        modelContext.insert(newCourse)
        dismiss()
    }
}

// MARK: - Course Detail View
struct CourseDetailView: View {
    @Bindable var course: Course
    
    @Environment(\.modelContext) private var modelContext
    
    @Query private var availableInstructors: [User]
    @Query private var availableStudents: [User]
    
    @State private var showingAssignInstructor = false
    @State private var showingEnrollStudent = false
    
    init(course: Course) {
        self.course = course
        
        // Query for instructors and directors
        let instructorRole = UserRole.instructor.rawValue
        let directorRole = UserRole.director.rawValue
        _availableInstructors = Query(
            filter: #Predicate<User> { user in
                user.roleRawValue == instructorRole ||
                user.roleRawValue == directorRole
            },
            sort: [SortDescriptor(\User.name)]
        )
        
        // Query for students
        let studentRole = UserRole.student.rawValue
        _availableStudents = Query(
            filter: #Predicate<User> { user in
                user.roleRawValue == studentRole
            },
            sort: [SortDescriptor(\User.name)]
        )
    }
    
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
                    }
                    .padding()
                    .pennStateCard()
                    .padding(.horizontal)
                    .padding(.top, 8)
                    
                    // Instructor Section
                    VStack(spacing: 12) {
                        PennStateSectionHeader(
                            "Instructor",
                            systemImage: "person.fill.checkmark"
                        )
                        
                        if let instructor = course.instructor {
                            HStack(spacing: 14) {
                                PennStateUserAvatar(
                                    name: instructor.name,
                                    role: instructor.role,
                                    size: 48
                                )
                                
                                VStack(alignment: .leading, spacing: 6) {
                                    Text(instructor.name)
                                        .font(.headline)
                                        .foregroundStyle(Color.pennStateNavy)
                                    
                                    Text(instructor.email)
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                                
                                Spacer()
                                
                                Button(role: .destructive) {
                                    removeInstructor()
                                } label: {
                                    Image(systemName: "person.badge.minus")
                                        .font(.body)
                                        .foregroundStyle(.red)
                                }
                            }
                            .padding()
                            .pennStateCard()
                            .padding(.horizontal)
                        } else {
                            PennStateEmptyState(
                                title: "No Instructor",
                                systemImage: "person.slash",
                                description: "This course doesn't have an assigned instructor yet.",
                                action: { showingAssignInstructor = true },
                                actionLabel: "Assign Instructor"
                            )
                            .frame(height: 200)
                        }
                    }
                    
                    // Students Section
                    VStack(spacing: 12) {
                        PennStateSectionHeader(
                            "Enrolled Students",
                            count: course.students.count,
                            systemImage: "person.2.fill"
                        )
                        
                        if course.students.isEmpty {
                            PennStateEmptyState(
                                title: "No Students",
                                systemImage: "person.2.slash",
                                description: "No students are enrolled in this course yet.",
                                action: { showingEnrollStudent = true },
                                actionLabel: "Enroll Student"
                            )
                            .frame(height: 200)
                        } else {
                            VStack(spacing: 10) {
                                ForEach(course.students) { student in
                                    StudentListCard(
                                        student: student,
                                        onDelete: { unenrollStudent(student) }
                                    )
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    
                    // Action Buttons
                    VStack(spacing: 12) {
                        if course.instructor == nil {
                            PennStateActionButton(
                                title: "Assign Instructor",
                                systemImage: "person.badge.plus",
                                color: Color.instructorAccent
                            ) {
                                showingAssignInstructor = true
                            }
                        }
                        
                        PennStateActionButton(
                            title: "Enroll Student",
                            systemImage: "person.badge.plus",
                            color: Color.studentAccent
                        ) {
                            showingEnrollStudent = true
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                }
            }
        }
        .navigationTitle(course.code)
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showingAssignInstructor) {
            AssignInstructorView(
                course: course,
                availableInstructors: availableInstructors
            )
        }
        .sheet(isPresented: $showingEnrollStudent) {
            EnrollStudentView(
                course: course,
                availableStudents: availableStudents.filter { student in
                    !course.students.contains(where: { $0.id == student.id })
                }
            )
        }
    }
    
    private func removeInstructor() {
        course.instructor = nil
    }
    
    private func unenrollStudent(_ student: User) {
        if let enrollment = course.enrollments.first(where: { $0.student.id == student.id }) {
            modelContext.delete(enrollment)
        }
    }
}

// MARK: - Assign Instructor View
struct AssignInstructorView: View {
    let course: Course
    let availableInstructors: [User]
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.pennStateLightGray.ignoresSafeArea()
                
                if availableInstructors.isEmpty {
                    PennStateEmptyState(
                        title: "No Instructors Available",
                        systemImage: "person.slash",
                        description: "There are no instructors in the system to assign to this course."
                    )
                } else {
                    ScrollView {
                        VStack(spacing: 10) {
                            ForEach(availableInstructors) { instructor in
                                Button {
                                    assignInstructor(instructor)
                                } label: {
                                    HStack(spacing: 14) {
                                        PennStateUserAvatar(
                                            name: instructor.name,
                                            role: instructor.role,
                                            size: 48
                                        )
                                        
                                        VStack(alignment: .leading, spacing: 6) {
                                            Text(instructor.name)
                                                .font(.headline)
                                                .foregroundStyle(Color.pennStateNavy)
                                            
                                            Text(instructor.email)
                                                .font(.caption)
                                                .foregroundStyle(.secondary)
                                            
                                            PennStateBadge(
                                                text: instructor.role.rawValue.capitalized,
                                                systemImage: "person.fill.checkmark",
                                                color: Color.instructorAccent
                                            )
                                        }
                                        
                                        Spacer()
                                        
                                        if course.instructor?.id == instructor.id {
                                            Image(systemName: "checkmark.circle.fill")
                                                .font(.title2)
                                                .foregroundStyle(.green)
                                        } else {
                                            Image(systemName: "arrow.right.circle.fill")
                                                .font(.title2)
                                                .foregroundStyle(Color.directorAccent)
                                        }
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
            .navigationTitle("Assign Instructor")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    private func assignInstructor(_ instructor: User) {
        course.instructor = instructor
        try? modelContext.save()
        dismiss()
    }
}
// MARK: - Enroll Student View
struct EnrollStudentView: View {
    let course: Course
    let availableStudents: [User]
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.pennStateLightGray.ignoresSafeArea()
                
                if availableStudents.isEmpty {
                    PennStateEmptyState(
                        title: "No Students Available",
                        systemImage: "person.slash",
                        description: "All students are already enrolled in this course."
                    )
                } else {
                    ScrollView {
                        VStack(spacing: 10) {
                            ForEach(availableStudents) { student in
                                Button {
                                    enrollStudent(student)
                                } label: {
                                    HStack(spacing: 14) {
                                        PennStateUserAvatar(
                                            name: student.name,
                                            role: .student,
                                            size: 48
                                        )
                                        
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
                                            .foregroundStyle(Color.studentAccent)
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
            .navigationTitle("Enroll Student")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
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
        dismiss()
    }
}

// MARK: - Previews
#Preview("Director Dashboard") {
    DirectorDashboardView(director: User(
        name: "Dr. Sarah Wilson",
        email: "swilson@example.edu",
        role: .director
    ))
    .modelContainer(PreviewContainer.shared)
}

#Preview("Add Course") {
    AddCourseView()
        .modelContainer(PreviewContainer.shared)
}

#Preview("Course Detail") {
    let container = PreviewContainer.shared
    let context = container.mainContext
    
    let course = try! context.fetch(FetchDescriptor<Course>()).first!
    
    return NavigationStack {
        CourseDetailView(course: course)
    }
    .modelContainer(container)
}


