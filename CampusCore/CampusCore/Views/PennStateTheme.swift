//
//  PennStateTheme.swift
//  CampusCore
//
//  Created by Nader Alfares on 2/22/26.
//

import SwiftUI

// MARK: - Penn State Color Palette
extension Color {
    // Primary Penn State Colors
    static let pennStateNavy = Color(red: 4/255, green: 30/255, blue: 66/255) // #041E42
    static let pennStateBlue = Color(red: 30/255, green: 64/255, blue: 124/255) // #1E407C
    
    // Accent Colors for different roles
    static let studentAccent = Color(red: 0/255, green: 95/255, blue: 169/255) // Lighter blue
    static let instructorAccent = Color(red: 30/255, green: 64/255, blue: 124/255) // Beaver Blue
    static let directorAccent = Color(red: 4/255, green: 30/255, blue: 66/255) // Nittany Navy
    
    // Supporting colors
    static let pennStateWhite = Color.white
    static let pennStateLightGray = Color(white: 0.95)
    static let pennStateMediumGray = Color(white: 0.7)
}

// MARK: - Theme Card Style
struct PennStateCardStyle: ViewModifier {
    var backgroundColor: Color = .pennStateWhite
    var hasShadow: Bool = true
    
    func body(content: Content) -> some View {
        content
            .background {
                RoundedRectangle(cornerRadius: 16)
                    .fill(backgroundColor)
                    .shadow(
                        color: hasShadow ? .black.opacity(0.06) : .clear,
                        radius: 12,
                        y: 4
                    )
            }
    }
}

extension View {
    func pennStateCard(backgroundColor: Color = .pennStateWhite, hasShadow: Bool = true) -> some View {
        modifier(PennStateCardStyle(backgroundColor: backgroundColor, hasShadow: hasShadow))
    }
}

// MARK: - Section Header Style
struct PennStateSectionHeader: View {
    let title: String
    let count: Int?
    let systemImage: String
    
    init(_ title: String, count: Int? = nil, systemImage: String = "square.grid.2x2") {
        self.title = title
        self.count = count
        self.systemImage = systemImage
    }
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: systemImage)
                .font(.headline)
                .foregroundStyle(Color.pennStateNavy)
            
            Text(title)
                .font(.headline)
                .foregroundStyle(Color.pennStateNavy)
            
            if let count = count {
                Spacer()
                Text("\(count)")
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(Color.pennStateBlue.opacity(0.7))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background {
                        Capsule()
                            .fill(Color.pennStateBlue.opacity(0.1))
                    }
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
}

// MARK: - Empty State View
struct PennStateEmptyState: View {
    let title: String
    let systemImage: String
    let description: String
    var action: (() -> Void)? = nil
    var actionLabel: String = "Get Started"
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: systemImage)
                .font(.system(size: 60))
                .foregroundStyle(Color.pennStateBlue.opacity(0.3))
                .symbolEffect(.pulse)
            
            VStack(spacing: 8) {
                Text(title)
                    .font(.title3.bold())
                    .foregroundStyle(Color.pennStateNavy)
                
                Text(description)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
            }
            
            if let action = action {
                Button(action: action) {
                    Text(actionLabel)
                        .font(.headline)
                        .foregroundStyle(.white)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 12)
                        .background {
                            Capsule()
                                .fill(Color.pennStateBlue)
                        }
                }
                .padding(.top, 8)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
}

// MARK: - User Avatar View
struct PennStateUserAvatar: View {
    let name: String
    let role: UserRole
    let size: CGFloat
    
    init(name: String, role: UserRole, size: CGFloat = 44) {
        self.name = name
        self.role = role
        self.size = size
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
    
    var body: some View {
        ZStack {
            Circle()
                .fill(roleColor.gradient.opacity(0.15))
                .frame(width: size, height: size)
            
            Circle()
                .strokeBorder(roleColor.opacity(0.3), lineWidth: 2)
                .frame(width: size, height: size)
            
            Text(name.prefix(1).uppercased())
                .font(.system(size: size * 0.4, weight: .bold, design: .rounded))
                .foregroundStyle(roleColor)
        }
    }
}

// MARK: - Badge View
struct PennStateBadge: View {
    let text: String
    let systemImage: String
    let color: Color
    
    var body: some View {
        Label(text, systemImage: systemImage)
            .font(.caption.weight(.medium))
            .foregroundStyle(color)
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background {
                Capsule()
                    .fill(color.opacity(0.12))
            }
    }
}

// MARK: - Action Button Style
struct PennStateActionButton: View {
    let title: String
    let systemImage: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Label(title, systemImage: systemImage)
                .font(.headline)
                .foregroundStyle(color)
                .frame(maxWidth: .infinity)
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(color.opacity(0.08))
                        .overlay {
                            RoundedRectangle(cornerRadius: 12)
                                .strokeBorder(color.opacity(0.3), lineWidth: 1.5)
                        }
                }
        }
    }
}

// MARK: - Dashboard Header
struct PennStateDashboardHeader: View {
    let user: User
    
    private var roleTitle: String {
        switch user.role {
        case .student:
            return "Student Portal"
        case .instructor:
            return "Instructor Portal"
        case .director:
            return "Director Portal"
        }
    }
    
    private var roleColor: Color {
        switch user.role {
        case .student:
            return .studentAccent
        case .instructor:
            return .instructorAccent
        case .director:
            return .directorAccent
        }
    }
    
    private var roleIcon: String {
        switch user.role {
        case .student:
            return "book.fill"
        case .instructor:
            return "person.fill.checkmark"
        case .director:
            return "star.fill"
        }
    }
    
    var body: some View {
        VStack(spacing: 16) {
            HStack(spacing: 16) {
                PennStateUserAvatar(name: user.name, role: user.role, size: 64)
                
                VStack(alignment: .leading, spacing: 6) {
                    Text(user.name)
                        .font(.title2.bold())
                        .foregroundStyle(Color.pennStateNavy)
                    
                    Text(user.email)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    
                    HStack(spacing: 6) {
                        Image(systemName: roleIcon)
                            .font(.caption)
                        Text(roleTitle)
                            .font(.caption.weight(.semibold))
                    }
                    .foregroundStyle(roleColor)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background {
                        Capsule()
                            .fill(roleColor.opacity(0.12))
                    }
                }
                
                Spacer()
            }
            .padding()
            .pennStateCard()
        }
        .padding(.horizontal)
    }
}
