//
//  SharedComponents.swift
//  CampusCore
//
//  Created by Nader Alfares on 2/22/26.
//

import SwiftUI

// MARK: - Stats Card
struct StatsCard: View {
    let title: String
    let value: String
    let systemImage: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: systemImage)
                    .font(.title2)
                    .foregroundStyle(color)
                
                Spacer()
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(value)
                    .font(.title.bold())
                    .foregroundStyle(Color.pennStateNavy)
                
                Text(title)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .pennStateCard()
    }
}

// MARK: - Student List Card
struct StudentListCard: View {
    let student: User
    let onDelete: () -> Void
    
    var body: some View {
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
            
            Button(role: .destructive) {
                onDelete()
            } label: {
                Image(systemName: "person.badge.minus")
                    .font(.body)
                    .foregroundStyle(.red)
            }
        }
        .padding()
        .pennStateCard()
    }
}

//MARK: Adding New Users
struct AddUserButton : View {
    var action : () -> Void
    var body : some View {
        Button {
            action()
        } label: {
            Label("Add New User", systemImage: "person.badge.plus")
                .font(.headline)
                .foregroundStyle(Color.pennStateBlue)
                .frame(maxWidth: .infinity)
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.pennStateBlue.opacity(0.08))
                        .overlay {
                            RoundedRectangle(cornerRadius: 12)
                                .strokeBorder(Color.pennStateBlue.opacity(0.3), lineWidth: 1.5)
                        }
                }
                .shadow(color: Color.pennStateBlue.opacity(0.15), radius: 8, y: 4)
        }
    }
}

struct RoleOptionButton: View {
    let role: UserRole
    let isSelected: Bool
    let action: () -> Void
    
    private var roleIcon: String {
        switch role {
        case .student: return "book.fill"
        case .instructor: return "person.fill.checkmark"
        case .director: return "star.fill"
        }
    }
    
    private var roleColor: Color {
        switch role {
        case .student: return .studentAccent
        case .instructor: return .instructorAccent
        case .director: return .directorAccent
        }
    }
    
    private var roleDescription: String {
        switch role {
        case .student: return "Enroll in courses and view grades"
        case .instructor: return "Teach and manage courses"
        case .director: return "Full administrative access"
        }
    }
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 14) {
                // Icon
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(
                            LinearGradient(
                                colors: isSelected
                                    ? [roleColor, roleColor.opacity(0.7)]
                                    : [Color.gray.opacity(0.2), Color.gray.opacity(0.15)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 48, height: 48)
                    
                    Image(systemName: roleIcon)
                        .font(.title3.weight(.semibold))
                        .foregroundStyle(isSelected ? .white : .secondary)
                }
                
                // Text
                VStack(alignment: .leading, spacing: 4) {
                    Text(role.rawValue.capitalized)
                        .font(.headline)
                        .foregroundStyle(isSelected ? Color.pennStateNavy : .primary)
                    
                    Text(roleDescription)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                }
                
                Spacer()
                
                // Selection Indicator
                ZStack {
                    Circle()
                        .strokeBorder(
                            isSelected ? roleColor : Color.gray.opacity(0.3),
                            lineWidth: 2
                        )
                        .frame(width: 24, height: 24)
                    
                    if isSelected {
                        Circle()
                            .fill(roleColor)
                            .frame(width: 14, height: 14)
                    }
                }
            }
            .padding(14)
            .background {
                RoundedRectangle(cornerRadius: 14)
                    .fill(.white)
                    .shadow(
                        color: isSelected ? roleColor.opacity(0.15) : Color.black.opacity(0.05),
                        radius: isSelected ? 10 : 6,
                        y: 2
                    )
            }
            .overlay {
                RoundedRectangle(cornerRadius: 14)
                    .strokeBorder(
                        isSelected ? roleColor.opacity(0.3) : Color.clear,
                        lineWidth: 2
                    )
            }
        }
        .buttonStyle(.plain)
    }
}

//MARK: MainView Header
struct CampusCoreHeaderView : View {
    var body : some View {
        VStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [Color.pennStateBlue, Color.pennStateNavy],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 90, height: 90)
                    .shadow(color: Color.pennStateNavy.opacity(0.3), radius: 12, y: 6)
                
                Image(systemName: "graduationcap.fill")
                    .font(.system(size: 44))
                    .foregroundStyle(.white)
            }
            
            Text("CampusCore")
                .font(.system(.largeTitle, design: .rounded, weight: .bold))
                .foregroundStyle(Color.pennStateNavy)
            
            Text("Select your role to continue")
                .font(.subheadline)
                .foregroundStyle(Color.pennStateBlue.opacity(0.8))
        }
    }
}


// MARK: - Role Selection Card
struct RoleSelectionCard: View {
    let role: UserRole
    
    private var roleIcon: String {
        switch role {
        case .student:
            return "book.fill"
        case .instructor:
            return "person.fill.checkmark"
        case .director:
            return "star.fill"
        }
    }
    
    private var roleColor: Color {
        switch role {
        case .student:
            return .studentAccent
        case .instructor:
            return .instructorAccent
        case .director:
            return .directorAccent
        }
    }
    
    private var roleDescription: String {
        switch role {
        case .student:
            return "View courses & enroll"
        case .instructor:
            return "Manage your courses"
        case .director:
            return "Full system access"
        }
    }
    
    var body: some View {
        HStack(spacing: 16) {
            // Icon
            ZStack {
                RoundedRectangle(cornerRadius: 14)
                    .fill(
                        LinearGradient(
                            colors: [roleColor, roleColor.opacity(0.7)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 56, height: 56)
                
                Image(systemName: roleIcon)
                    .font(.title2.weight(.semibold))
                    .foregroundStyle(.white)
            }
            
            // Text
            VStack(alignment: .leading, spacing: 6) {
                Text(role.rawValue.capitalized)
                    .font(.title3.bold())
                    .foregroundStyle(Color.pennStateNavy)
                
                Text(roleDescription)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            // Chevron
            Image(systemName: "chevron.right")
                .font(.body.weight(.semibold))
                .foregroundStyle(roleColor.opacity(0.5))
        }
        .padding(18)
        .background {
            RoundedRectangle(cornerRadius: 16)
                .fill(.white)
                .shadow(color: roleColor.opacity(0.12), radius: 12, y: 4)
        }
    }
}
