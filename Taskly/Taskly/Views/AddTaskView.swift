//
//  AddTaskView.swift
//  Taskly
//
//  Created by Nader Alfares on 3/5/26.
//

import SwiftUI

struct AddTaskView: View {
    @Binding var title: String
    @Binding var description: String
    let onSave: () -> Void
    let onCancel: () -> Void
    
    @FocusState private var isTitleFocused: Bool
    
    var body: some View {
        NavigationStack {
            ZStack {
                backgroundGradient
                
                formContent
            }
            .navigationTitle("New Task")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.pennStateBlue, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        onCancel()
                    }
                    .foregroundStyle(.white)
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        onSave()
                    }
                    .disabled(isSaveDisabled)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                }
            }
            .onAppear {
                isTitleFocused = true
            }
        }
        .tint(.pennStateBlue)
    }
    
    // MARK: - Subviews
    
    private var backgroundGradient: some View {
        LinearGradient(
            colors: [Color.pennStateBlue.opacity(0.03), Color.pennStateLightBlue.opacity(0.05)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
    }
    
    private var formContent: some View {
        Form {
            titleSection
            descriptionSection
        }
        .scrollContentBackground(.hidden)
    }
    
    private var titleSection: some View {
        Section {
            TextField("Task Title", text: $title)
                .focused($isTitleFocused)
                .font(.body)
        } header: {
            Text("Title")
                .foregroundStyle(Color.pennStateBlue)
                .fontWeight(.semibold)
        }
        .listRowBackground(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
        )
    }
    
    private var descriptionSection: some View {
        Section {
            TextField("Task Description", text: $description, axis: .vertical)
                .lineLimit(3...8)
                .font(.body)
        } header: {
            Text("Description")
                .foregroundStyle(Color.pennStateBlue)
                .fontWeight(.semibold)
        } footer: {
            HStack(spacing: 4) {
                Image(systemName: "info.circle.fill")
                    .font(.caption2)
                Text("Optional - Add more details about this task")
            }
            .foregroundStyle(.secondary)
        }
        .listRowBackground(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
        )
    }
    
    // MARK: - Computed Properties
    
    private var isSaveDisabled: Bool {
        title.trimmingCharacters(in: .whitespaces).isEmpty
    }
}

#Preview {
    AddTaskView(
        title: .constant(""),
        description: .constant(""),
        onSave: { print("Save tapped") },
        onCancel: { print("Cancel tapped") }
    )
}
