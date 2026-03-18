//
//  SignupView.swift
//  Taskly
//
//  Created by Nader Alfares on 3/16/26.
//

import SwiftUI

struct SignupView: View {
    @Environment(NetworkManager.self) private var networkManager
    @Environment(AuthManager.self) private var authManager
    @Environment(\.dismiss) private var dismiss
    
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var isLoading = false
    @State private var showError = false
    @State private var errorMessage = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background
                LinearGradient(
                    colors: [Color.pennStateBlue, Color.pennStateLightBlue],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack(spacing: 30) {
                    Spacer()
                    
                    // Logo/Title
                    VStack(spacing: 10) {
                        Image(systemName: "person.circle.fill")
                            .font(.system(size: 80))
                            .foregroundStyle(.white)
                        
                        Text("Create Account")
                            .font(.system(size: 36, weight: .bold))
                            .foregroundStyle(.white)
                    }
                    
                    
                    // Signup Form
                    VStack(spacing: 20) {
                        // Email Field
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Email")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                            
                            TextField("", text: $email)
                                .textFieldStyle(AuthTextFieldStyle())
                                .textInputAutocapitalization(.never)
                                .keyboardType(.emailAddress)
                                .autocorrectionDisabled()
                        }
                        
                        // Password Field
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Password")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                            
                            SecureField("", text: $password)
                                .textFieldStyle(AuthTextFieldStyle())
                        }
                        
                        // Confirm Password Field
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Confirm Password")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                            
                            SecureField("", text: $confirmPassword)
                                .textFieldStyle(AuthTextFieldStyle())
                        }
                        
                        // Error message for password mismatch
                        if !password.isEmpty && !confirmPassword.isEmpty && password != confirmPassword {
                            Text("Passwords don't match")
                                .font(.caption)
                                .foregroundStyle(.red)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        
                        // Sign Up Button
                        Button(action: signup) {
                            HStack {
                                if isLoading {
                                    ProgressView()
                                        .tint(.pennStateBlue)
                                } else {
                                    Text("Sign Up")
                                        .fontWeight(.semibold)
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(.white)
                            .foregroundStyle(Color.pennStateBlue)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                        .disabled(isLoading || !isValidForm)
                    }
                    .padding(.horizontal, 30)
                    
                    Spacer()
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title2)
                            .foregroundStyle(.white)
                            .symbolRenderingMode(.hierarchical)
                    }
                }
            }
            .alert("Error", isPresented: $showError) {
                Button("OK") { showError = false }
            } message: {
                Text(errorMessage)
            }
        }
    }
    
    // MARK: - Computed Properties
    
    private var isValidForm: Bool {
        !email.isEmpty && 
        !password.isEmpty && 
        !confirmPassword.isEmpty && 
        password == confirmPassword &&
        password.count >= 6
    }
    
    // MARK: - Actions
    
    private func signup() {
        //TODO: signup action
    }
}

#Preview {
    SignupView()
        .environment(NetworkManager())
        .environment(AuthManager())
}
