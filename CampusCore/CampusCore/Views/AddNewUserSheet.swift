//
//  AddNewUserSheet.swift
//  CampusCore
//
//  Created by Nader Alfares on 2/23/26.
//
import SwiftUI
import SwiftData

// MARK: - Add New User Sheet
struct AddNewUserSheet: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var role: UserRole = .student
    
    var isFormValid: Bool {
        !name.isEmpty && !email.isEmpty && email.contains("@")
    }
    
    private var selectedRoleColor: Color {
        switch role {
        case .student: return .studentAccent
        case .instructor: return .instructorAccent
        case .director: return .directorAccent
        }
    }
    
    private var selectedRoleIcon: String {
        switch role {
        case .student: return "book.fill"
        case .instructor: return "person.fill.checkmark"
        case .director: return "star.fill"
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    // Header with Icon
                    VStack(spacing: 16) {
                        VStack(spacing: 4) {
                            Text("Add New User")
                                .font(.title2.bold())
                                .foregroundStyle(Color.pennStateNavy)
                            Text("Create a new user account")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                                .animation(.easeInOut, value: role)
                        }
                    }
                    .padding(.top, 20)
                    
                    // User Information Section
                    VStack(alignment: .leading, spacing: 16) {
                        SectionHeaderLabel(title: "User Information", icon: "person.text.rectangle")
                        
                        VStack(spacing: 12) {
                            CustomTextField(
                                icon: "person.fill",
                                placeholder: "Full Name",
                                text: $name
                            )
                            .textContentType(.name)
                            
                            CustomTextField(
                                icon: "envelope.fill",
                                placeholder: "Email Address",
                                text: $email
                            )
                            .textContentType(.emailAddress)
                            .keyboardType(.emailAddress)
                            .textInputAutocapitalization(.never)
                        }
                    }
                    .padding(.horizontal)
                    
                    // Role Selection Section
                    VStack(alignment: .leading, spacing: 16) {
                        SectionHeaderLabel(title: "Select Role", icon: "person.2.fill")
                        
                        VStack(spacing: 10) {
                            ForEach(UserRole.allCases, id: \.self) { roleOption in
                                RoleOptionButton(
                                    role: roleOption,
                                    isSelected: role == roleOption
                                ) {
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                        role = roleOption
                                    }
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    // Add Button
                    Button {
                        addUser()
                    } label: {
                        HStack(spacing: 8) {
                            Image(systemName: "person.badge.plus")
                                .font(.headline)
                            Text("Add User")
                                .font(.headline.bold())
                        }
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 14)
                                .fill(
                                    LinearGradient(
                                        colors: isFormValid
                                            ? [selectedRoleColor, selectedRoleColor.opacity(0.8)]
                                            : [Color.gray.opacity(0.3), Color.gray.opacity(0.3)],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                        }
                        .shadow(
                            color: isFormValid ? selectedRoleColor.opacity(0.3) : .clear,
                            radius: 12,
                            y: 6
                        )
                    }
                    .disabled(!isFormValid)
                    .padding(.horizontal)
                    .padding(.top, 8)
                    .animation(.easeInOut, value: isFormValid)
                    
                    Spacer(minLength: 20)
                }
            }
            .background(Color(.systemGroupedBackground))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
                
                ToolbarItem(placement: .principal) {
                    Text("")
                }
            }
        }
    }
    
    private func addUser() {
        //TODO: Add User into DB
        dismiss()
    }
}
