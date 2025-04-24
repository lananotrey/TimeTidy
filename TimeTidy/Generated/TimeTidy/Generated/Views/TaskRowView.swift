import SwiftUI

struct TaskRowView: View {
    @State private var item: TaskItem
    @State private var showingEditSheet = false
    @State private var showingShareSheet = false
    let onUpdate: (TaskItem) -> Void
    let onDelete: () -> Void
    
    init(task: TaskItem, onUpdate: @escaping (TaskItem) -> Void, onDelete: @escaping () -> Void) {
        _item = State(initialValue: task)
        self.onUpdate = onUpdate
        self.onDelete = onDelete
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Button(action: toggleCompletion) {
                    Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(item.isCompleted ? .green : .gray)
                        .font(.title2)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(item.title)
                        .font(.headline)
                        .strikethrough(item.isCompleted)
                    
                    Text(item.description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                }
                
                Spacer()
                
                HStack(spacing: 16) {
                    Button(action: { showingShareSheet = true }) {
                        Image(systemName: "square.and.arrow.up")
                            .foregroundColor(.blue)
                    }
                    
                    Button(action: { showingEditSheet = true }) {
                        Image(systemName: "pencil")
                            .foregroundColor(.blue)
                    }
                    
                    Button(action: onDelete) {
                        Image(systemName: "trash")
                            .foregroundColor(.red)
                    }
                }
            }
            
            HStack {
                Label(item.dueDate.formatted(date: .abbreviated, time: .shortened),
                      systemImage: "calendar")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                Text(item.priority.rawValue)
                    .font(.caption)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color(item.priority.color))
                    .foregroundColor(.white)
                    .clipShape(Capsule())
            }
        }
        .padding()
        .background(Color("TaskBackground"))
        .cornerRadius(12)
        .shadow(radius: 2)
        .sheet(isPresented: $showingEditSheet) {
            EditTaskView(task: item) { updatedTask in
                item = updatedTask
                onUpdate(updatedTask)
            }
        }
        .sheet(isPresented: $showingShareSheet) {
            ShareSheet(items: [
                "Task: \(item.title)\nDescription: \(item.description)\nDue Date: \(item.dueDate.formatted())\nPriority: \(item.priority.rawValue)"
            ])
        }
    }
    
    private func toggleCompletion() {
        item.isCompleted.toggle()
        onUpdate(item)
    }
}