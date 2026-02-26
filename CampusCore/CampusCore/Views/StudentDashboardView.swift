//
//  StudentDashboardView.swift
//  CampusCore
//
//  Created by Nader Alfares on 2/21/26.
//
import SwiftUI
import SwiftData

struct StudentDashboardView: View {
    var student: User
    
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Course.code) private var allCourses: [Course]
    @Query private var enrollments: [Enrollment]
    
    
    init(student: User) {
        self.student = student
        let studentID = student.id
        let filter = #Predicate<Enrollment> { enrollment in
            enrollment.student.id == studentID
        }
        
        _enrollments = Query(filter: filter)
    }
    
    
    @State private var showingBrowseCourses = false

    
    var body: some View {
        ZStack {
            Color.pennStateLightGray.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20) {
                    // User Header
                    PennStateDashboardHeader(user: student)
                        .padding(.top, 8)
                    
                    // Stats Card
                    HStack(spacing: 16) {
                        StatsCard(
                            title: "Enrolled",
                            value: "\(enrollments.count)",
                            systemImage: "book.fill",
                            color: .studentAccent
                        )
                        
                        StatsCard(
                            title: "Courses",
                            value: "\(allCourses.count)",
                            systemImage: "square.grid.2x2.fill",
                            color: .pennStateBlue
                        )
                    }
                    .padding(.horizontal)
                    
                    // Courses Section
                    VStack(spacing: 12) {
                        PennStateSectionHeader(
                            "My Courses",
                            count: enrollments.count,
                            systemImage: "book.closed.fill"
                        )
                        
                        if enrollments.isEmpty {
                            PennStateEmptyState(
                                title: "No Courses Yet",
                                systemImage: "book.closed",
                                description: "Browse available courses and enroll to get started.",
                                action: { showingBrowseCourses = true },
                                actionLabel: "Browse Courses"
                            )
                            .frame(height: 300)
                        } else {
                            VStack(spacing: 10) {
                                ForEach(enrollments) { enr in
                                    NavigationLink {
                                        StudentCourseDetailView(course: enr.course, student: enr.student)
                                    } label: {
                                        StudentCourseCard(course: enr.course)
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
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    showingBrowseCourses = true
                } label: {
                    Label("Browse", systemImage: "magnifyingglass")
                        .foregroundStyle(Color.studentAccent)
                }
            }
        }
        .sheet(isPresented: $showingBrowseCourses) {
            BrowseCoursesView(student: student)
        }
    }
}



// MARK: - Student Course Card
struct StudentCourseCard: View {
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
                    .foregroundStyle(Color.studentAccent.opacity(0.5))
            }
            
            Divider()
            
            HStack(spacing: 12) {
                PennStateBadge(
                    text: course.term,
                    systemImage: "calendar",
                    color: .pennStateBlue
                )
                
                if let instructor = course.instructor {
                    PennStateBadge(
                        text: instructor.name,
                        systemImage: "person.fill",
                        color: .studentAccent
                    )
                }
                
                Spacer()
                
                PennStateBadge(
                    text: "\(course.students.count)",
                    systemImage: "person.2.fill",
                    color: .pennStateMediumGray
                )
            }
        }
        .padding()
        .pennStateCard()
    }
}

// MARK: - Student Course Detail View
struct StudentCourseDetailView: View {
    let course: Course
    let student: User
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    var isEnrolled: Bool {
        student.enrollments.contains { $0.course.id == course.id }
    }
    
    var body: some View {
        ZStack {
            Color.pennStateLightGray.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20) {
                    // Course Header Card
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
                        
                        VStack(spacing: 12) {
                            InfoRow(label: "Term", value: course.term, systemImage: "calendar")
                            
                            if let instructor = course.instructor {
                                InfoRow(
                                    label: "Instructor",
                                    value: instructor.name,
                                    systemImage: "person.fill",
                                    subtitle: instructor.email
                                )
                            }
                            
                            InfoRow(
                                label: "Enrolled",
                                value: "\(course.students.count) students",
                                systemImage: "person.2.fill"
                            )
                        }
                    }
                    .padding()
                    .pennStateCard()
                    .padding(.horizontal)
                    .padding(.top, 8)
                    
                    // Action Button
                    if isEnrolled {
                        Button(role: .destructive) {
                            unenroll()
                        } label: {
                            Label("Unenroll from Course", systemImage: "person.badge.minus")
                                .font(.headline)
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background {
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(.red)
                                }
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.bottom, 20)
            }
        }
        .navigationTitle(course.code)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func unenroll() {
        if let enrollment = student.enrollments.first(where: { $0.course.id == course.id }) {
            modelContext.delete(enrollment)
            try? modelContext.save()
        }
    }
}

// MARK: - Info Row
struct InfoRow: View {
    let label: String
    let value: String
    let systemImage: String
    var subtitle: String? = nil
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: systemImage)
                .font(.body)
                .foregroundStyle(Color.studentAccent)
                .frame(width: 24)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(label)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                
                Text(value)
                    .font(.body.weight(.medium))
                    .foregroundStyle(Color.pennStateNavy)
                
                if let subtitle = subtitle {
                    Text(subtitle)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            
            Spacer()
        }
    }
}
// MARK: - Browse Courses View
struct BrowseCoursesView: View {
    @Bindable var student: User
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @Query(sort:[SortDescriptor(\Course.code)]) var courses : [Course]
    
    @State private var searchText = ""
    
    var enrolledCourseIDs: Set<UUID> {
        Set(student.enrollments.map { $0.course.id })
    }
    
    var filteredCourses: [Course] {
        let courses = courses.filter { course in
            searchText.isEmpty ||
            course.code.localizedCaseInsensitiveContains(searchText) ||
            course.title.localizedCaseInsensitiveContains(searchText) ||
            course.term.localizedCaseInsensitiveContains(searchText)
        }
        return courses.sorted { $0.code < $1.code }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.pennStateLightGray.ignoresSafeArea()
                
                Group {
                    if courses.isEmpty {
                        PennStateEmptyState(
                            title: "No Courses Available",
                            systemImage: "books.vertical.slash",
                            description: "There are no courses available at this time. Check back later."
                        )
                    } else if filteredCourses.isEmpty {
                        PennStateEmptyState(
                            title: "No Results",
                            systemImage: "magnifyingglass",
                            description: "No courses match your search. Try different keywords."
                        )
                    } else {
                        ScrollView {
                            VStack(spacing: 10) {
                                ForEach(filteredCourses) { course in
                                    BrowseCourseCard(
                                        course: course,
                                        isEnrolled: enrolledCourseIDs.contains(course.id),
                                        onEnroll: { enrollInCourse(course) }
                                    )
                                }
                            }
                            .padding()
                        }
                    }
                }
            }
            .navigationTitle("Browse Courses")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $searchText, prompt: "Search courses...")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    private func enrollInCourse(_ course: Course) {
        
        let enrollment = Enrollment(student: student, course: course)
        modelContext.insert(enrollment)
        try? modelContext.save()
        
        
    }
}

// MARK: - Browse Course Card
struct BrowseCourseCard: View {
    let course: Course
    let isEnrolled: Bool
    let onEnroll: () -> Void
    
    var body: some View {
        HStack(spacing: 14) {
            VStack(alignment: .leading, spacing: 8) {
                Text(course.code)
                    .font(.headline.weight(.bold))
                    .foregroundStyle(Color.pennStateNavy)
                
                Text(course.title)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
                
                HStack(spacing: 8) {
                    PennStateBadge(
                        text: course.term,
                        systemImage: "calendar",
                        color: .pennStateBlue
                    )
                    
                    if let instructor = course.instructor {
                        PennStateBadge(
                            text: instructor.name,
                            systemImage: "person.fill",
                            color: .studentAccent
                        )
                    }
                }
            }
            
            Spacer()
            
            if isEnrolled {
                Image(systemName: "checkmark.circle.fill")
                    .font(.title2)
                    .foregroundStyle(.green)
            } else {
                Button(action: onEnroll) {
                    Image(systemName: "plus.circle.fill")
                        .font(.title2)
                        .foregroundStyle(Color.studentAccent)
                }
            }
        }
        .padding()
        .pennStateCard()
    }
}

// MARK: - Previews
#Preview("Student Dashboard - With Courses") {
    let container = PreviewContainer.shared
    let context = container.mainContext
    
    // Get a student with enrollments
    let students = try! context.fetch(FetchDescriptor<User>(
        predicate: #Predicate<User> { user in
            user.roleRawValue == "student"
        }
    ))
    
    let student = students.first ?? User(
        name: "Alice Johnson",
        email: "alice@example.edu",
        role: .student
    )
    
    NavigationStack {
        StudentDashboardView(student: student)
            .modelContainer(container)
    }
}
//
//#Preview("Student Dashboard - No Courses") {
//    StudentDashboardView(student: User(
//        name: "Bob Smith",
//        email: "bob@example.edu",
//        role: .student
//    ))
//    .modelContainer(PreviewContainer.shared)
//}
//
//#Preview("Browse Courses") {
//    let container = PreviewContainer.shared
//    let context = container.mainContext
//    
//    let student = User(
//        name: "Charlie Brown",
//        email: "charlie@example.edu",
//        role: .student
//    )
//    
//    let courses = try! context.fetch(FetchDescriptor<Course>())
//    
//    return BrowseCoursesView(student: student, allCourses: courses)
//        .modelContainer(container)
//}
//
//#Preview("Student Course Detail") {
//    let container = PreviewContainer.shared
//    let context = container.mainContext
//    
//    let student = User(
//        name: "Diana Prince",
//        email: "diana@example.edu",
//        role: .student
//    )
//    let course = try! context.fetch(FetchDescriptor<Course>()).first!
//    
//    return NavigationStack {
//        StudentCourseDetailView(course: course, student: student)
//    }
//    .modelContainer(container)
//}


