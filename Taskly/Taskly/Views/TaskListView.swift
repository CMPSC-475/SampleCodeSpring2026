//
//  TaskListView.swift
//  Taskly
//
//  Created by Nader Alfares on 3/5/26.
//

import SwiftUI

struct TaskListView: View {
    let tasks: [TasklyItem]
    let onToggleTask: (String, Bool) -> Void
    let onDeleteTask: (IndexSet) -> Void
    
    var body: some View {
        List {
            ForEach(tasks) { task in
                TaskRow(task: task) {
                    onToggleTask(task.id, !task.completed)
                }
                .listRowBackground(taskRowBackground)
            }
            .onDelete(perform: onDeleteTask)
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
    }
    
    // MARK: - Subviews
    
    private var taskRowBackground: some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(Color.white)
            .shadow(color: Color.pennStateBlue.opacity(0.1), radius: 2, x: 0, y: 1)
            .padding(.vertical, 4)
    }
}

#Preview {
    TaskListView(
        tasks: [
            TasklyItem(id: "1", title: "Sample Task", description: "Description", completed: false),
            TasklyItem(id: "2", title: "Completed Task", description: "Done!", completed: true)
        ],
        onToggleTask: { id, completed in
            print("Toggle task \(id) to \(completed)")
        },
        onDeleteTask: { offsets in
            print("Delete at \(offsets)")
        }
    )
}
