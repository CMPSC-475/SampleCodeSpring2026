//
//  MainView.swift
//  Taskly
//
//  Created by Nader Alfares on 3/1/26.
//

import SwiftUI

struct MainView: View {
    @Environment(NetworkManager.self) var networkManager
    @Environment(AuthManager.self) var authManager
    @State private var tasks: [TasklyItem] = []
    @State private var isLoading = false
    @State private var errorMessage: String?
    @State private var showError = false
    @State private var showAddTask = false
    @State private var newTaskTitle = ""
    @State private var newTaskDescription = ""
    @State private var showLogoutConfirmation = false
    
    var body: some View {
        NavigationStack {
            Group {
                if isLoading && tasks.isEmpty {
                    LoadingView()
                } else if tasks.isEmpty {
                    EmptyStateView()
                } else {
                    TaskListView(
                        tasks: tasks,
                        onToggleTask: markTaskAs,
                        onDeleteTask: deleteTask
                    )
                }
            }
            .background { backgroundGradient }
            .navigationTitle("Taskly")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.pennStateBlue, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbar { toolbar }
            .onAppear { loadTasks() }
            .refreshable { await loadTasksAsync() }
            .alert("Error", isPresented: $showError) {
                Button("OK") { showError = false }
            } message: {
                Text(errorMessage ?? "An unknown error occurred")
            }
            .alert("Log Out", isPresented: $showLogoutConfirmation) {
                Button("Cancel", role: .cancel) { }
                Button("Log Out", role: .destructive) {
                    logout()
                }
            } message: {
                Text("Are you sure you want to log out?")
            }
            .sheet(isPresented: $showAddTask) { addTaskSheet }
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
    
    @ToolbarContentBuilder
    private var toolbar: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Button {
                showLogoutConfirmation = true
            } label: {
                Image(systemName: "pip.exit")
                    .font(.title3)
                    .foregroundStyle(.white)
            }
        }
        
        ToolbarItem(placement: .topBarTrailing) {
            HStack(spacing: 16) {
                
                
                Button {
                    showAddTask = true
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.title2)
                        .foregroundStyle(.white)
                        .symbolRenderingMode(.hierarchical)
                }
            }
        }
    }
    
    private var addTaskSheet: some View {
        AddTaskView(
            title: $newTaskTitle,
            description: $newTaskDescription,
            onSave: createNewTask,
            onCancel: {
                resetNewTaskForm()
                showAddTask = false
            }
        )
    }
    
    // MARK: - Actions
    private func loadTasks() {
        Task {
            await loadTasksAsync()
        }
    }
    
    private func loadTasksAsync() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            tasks = try await networkManager.getTasks()
        } catch {
            handleError("Failed to load tasks", error: error)
        }
    }
    
    private func markTaskAs(taskId: String, completed: Bool) {
        Task {
            do {
                // Optimistically update UI
                updateTaskLocally(taskId: taskId, completed: completed)
                
                // Make the API call
                try await networkManager.markTaskAs(completed: completed, taskId: taskId)
                
                // Refresh to get the latest state from server
                await loadTasksAsync()
            } catch {
                // Revert the optimistic update
                await loadTasksAsync()
                handleError("Failed to update task", error: error)
            }
        }
    }
    
    private func createNewTask() {
        Task {
            do {
                _ = try await networkManager.createTask(
                    title: newTaskTitle,
                    description: newTaskDescription
                )
                
                await loadTasksAsync()
                
                resetNewTaskForm()
                showAddTask = false
            } catch {
                handleError("Failed to create task", error: error)
            }
        }
    }
    
    private func deleteTask(at offsets: IndexSet) {
        Task {
            for index in offsets {
                let task = tasks[index]
                
                // Optimistically remove from UI
                tasks.remove(atOffsets: offsets)
                
                do {
                    try await networkManager.deleteTask(taskId: task.id)
                    await loadTasksAsync()
                } catch {
                    // Revert the optimistic update by refreshing
                    await loadTasksAsync()
                    handleError("Failed to delete task", error: error)
                }
            }
        }
    }
    
    // MARK: - Helper Methods
    
    private func updateTaskLocally(taskId: String, completed: Bool) {
        guard let index = tasks.firstIndex(where: { $0.id == taskId }) else { return }
        
        tasks[index] = TasklyItem(
            id: tasks[index].id,
            title: tasks[index].title,
            description: tasks[index].description,
            completed: completed,
            ownerId: tasks[index].ownerId
        )
    }
    
    private func resetNewTaskForm() {
        newTaskTitle = ""
        newTaskDescription = ""
    }
    
    private func handleError(_ message: String, error: Error) {
        // Check if error is unauthorized
        if case NetworkManager.NetworkError.unauthorized = error {
            //TODO: uncomment for logout
            //authManager.logout()
            return
        }
        
        errorMessage = "\(message): \(error.localizedDescription)"
        showError = true
    }
    
    private func logout() {
        //TODO: uncomment for logout
        //authManager.logout()
        tasks = []
    }
}

//#Preview {
//    let networkManager = NetworkManager()
//    let authManager = AuthManager()
//    authManager.setToken("set token")
//    networkManager.configure(authManager: authManager)
//    return MainView()
//        .environment(networkManager)
//        .environment(authManager)
//}
