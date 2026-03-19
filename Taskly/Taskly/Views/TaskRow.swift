//
//  TaskRow.swift
//  Taskly
//
//  Created by Nader Alfares on 3/5/26.
//

import SwiftUI

struct TaskRow: View {
    let task: TasklyItem
    let onToggle: () -> Void
    
    var body: some View {
        Button(action: onToggle) {
            HStack(spacing: 16) {
                checkmarkCircle
                
                taskContent
                
                Spacer()
                
                if task.completed {
                    completedBadge
                }
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
    
    // MARK: - Subviews
    private var checkmarkCircle: some View {
        ZStack {
            Circle()
                .stroke(task.completed ? Color.pennStateBlue : Color.pennStateAccent, lineWidth: 2.5)
                .frame(width: 32, height: 32)
            
            if task.completed {
                Image(systemName: "checkmark")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundStyle(.white)
            }
        }
        .background(
            Circle()
                .fill(task.completed ? Color.pennStateBlue : Color.clear)
                .frame(width: 32, height: 32)
        )
        .contentTransition(.symbolEffect(.replace))
        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: task.completed)
    }
    
    private var taskContent: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(task.title)
                .font(.system(.body, design: .rounded, weight: .medium))
                .foregroundStyle(task.completed ? .secondary : Color.pennStateBlue)
                .strikethrough(task.completed, color: .secondary)
            
            if !task.description.isEmpty {
                Text(task.description)
                    .font(.system(.caption, design: .rounded))
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
            }
        }
    }
    
    private var completedBadge: some View {
        Image(systemName: "checkmark.seal.fill")
            .font(.title3)
            .foregroundStyle(Color.pennStateBlue)
            .symbolEffect(.pulse, value: task.completed)
    }
}

#Preview {
    List {
        TaskRow(task: TasklyItem(
            id: "1",
            title: "Sample Task",
            description: "This is a sample task description",
            completed: false
        )) {
            print("Toggle tapped")
        }
        
        TaskRow(task: TasklyItem(
            id: "2",
            title: "Completed Task",
            description: "This task is completed",
            completed: true
        )) {
            print("Toggle tapped")
        }
    }
}
