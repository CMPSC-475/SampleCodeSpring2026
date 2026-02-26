//
//  MainView.swift
//  CampusCore
//
//  Created by Nader Alfares on 2/21/26.
//

import SwiftUI
import SwiftData

struct MainView: View {
    @State private var showingAddUser = false
    var body: some View {
        NavigationStack {
            VStack(spacing: 28) {
                CampusCoreHeaderView()
                    .padding(.top, 40)
                
                // Role Selection Cards
                VStack(spacing: 14) {
                    ForEach(UserRole.allCases, id: \.self) { role in
                        NavigationLink {
                            UserListView(selectedRole: role)
                        } label: {
                            RoleSelectionCard(role: role)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal)
                
                // Quick Add User Button
                AddUserButton {
                    showingAddUser.toggle()
                }
                .padding(.horizontal)
                .padding(.bottom, 40)
            }
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showingAddUser) {
                AddNewUserSheet()
            }
        }
    }
}

// MARK: - Supporting Views for AddNewUserSheet
struct SectionHeaderLabel: View {
    let title: String
    let icon: String
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: icon)
                .font(.caption.bold())
            Text(title)
                .font(.subheadline.bold())
        }
        .foregroundStyle(Color.pennStateNavy)
        .textCase(.uppercase)
    }
}

struct CustomTextField: View {
    let icon: String
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.body)
                .foregroundStyle(Color.pennStateBlue)
                .frame(width: 24)
            
            TextField(placeholder, text: $text)
                .font(.body)
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 12)
                .fill(.white)
                .shadow(color: Color.black.opacity(0.05), radius: 8, y: 2)
        }
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .strokeBorder(Color.pennStateBlue.opacity(0.15), lineWidth: 1)
        }
    }
}



// MARK: - User List View
struct UserListView: View {
    let selectedRole: UserRole
    @Query private var users: [User]
    
    private var roleColor: Color {
        switch selectedRole {
        case .student: return .blue
        case .instructor: return .green
        case .director: return .purple
        }
    }
    
    init(selectedRole: UserRole) {
        self.selectedRole = selectedRole
        
        let roleRawValue = selectedRole.rawValue
        let filter = #Predicate<User> { user in
            user.roleRawValue == roleRawValue
        }
        let sortDescriptor = [SortDescriptor(\User.name, order: .forward)]
        
        _users = Query(filter: filter, sort: sortDescriptor)
    }

    
    var body: some View {
        Group {
            if users.isEmpty {
                ContentUnavailableView {
                    Label("No \(selectedRole.rawValue.capitalized)s", 
                          systemImage: "person.slash")
                } description: {
                    Text("There are no users with the \(selectedRole.rawValue) role yet.")
                } actions: {
                    Text("Add users from the main screen to get started.")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            } else {
                List {
                    ForEach(users) { user in
                        NavigationLink {
                            UserDashboardRouter(user: user)
                        } label: {
                            UserRowView(user: user, roleColor: roleColor)
                        }
                    }
                }
                .listStyle(.insetGrouped)
            }
        }
        .navigationTitle("\(selectedRole.rawValue.capitalized)s")
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .status) {
                if !users.isEmpty {
                    Text("\(users.count) \(users.count == 1 ? "user" : "users")")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
        }
    }
}

// MARK: - User Row View
struct UserRowView: View {
    let user: User
    let roleColor: Color
    
    var body: some View {
        HStack(spacing: 14) {
            // Avatar
            PennStateUserAvatar(name: user.name, role: user.role, size: 48)
            
            // User Info
            VStack(alignment: .leading, spacing: 6) {
                Text(user.name)
                    .font(.headline)
                    .foregroundStyle(Color.pennStateNavy)
                
                Label(user.email, systemImage: "envelope.fill")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
            }
            
            Spacer()
        }
        .padding(.vertical, 8)
    }
}

struct UserDashboardRouter: View {
    var user : User
    var body: some View {
        switch user.role {
        case .student:
            StudentDashboardView(student: user)
        case .instructor:
            InstructorDashboardView(instructor: user)
        case .director:
            DirectorDashboardView(director: user)
        }
    }
}

#Preview("Main View") {
    MainView()
        .modelContainer(PreviewContainer.shared)
}

