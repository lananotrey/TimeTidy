import SwiftUI

struct TaskRowView: View {
    @State private var task: Task
    let onUpdate: (Task) -> Void
    let onDelete: () -> Void
    
    init(task: Task, onUpdate: @escaping (Task) -> Void, onDelete: @escaping () -> Void) {
        _task = State(initialValue: task)
        self.onUpdate = onUpdate
        self.onDelete = onDelete
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Button(action: toggleCompletion) {
                    Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(task.isCompleted ? .green : .gray)
                        .font(.title2)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(task.title)
                        .font(.headline)
                        .strikethrough(task.isCompleted)
                    
                    Text(task.description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                }
                
                Spacer()
                
                Button(action: onDelete) {
                    Image(systemName: "trash")
                        .foregroundColor(.red)
                }
            }
            
            HStack {
                Label(task.dueDate.formatted(date: .abbreviated, time: .shortened),
                      systemImage: "calendar")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                Text(task.priority.rawValue)
                    .font(.caption)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color(task.priority.color))
                    .foregroundColor(.white)
                    .clipShape(Capsule())
            }
        }
        .padding()
        .background(Color("TaskBackground"))
        .cornerRadius(12)
        .shadow(radius: 2)
    }
    
    private func toggleCompletion() {
        task.isCompleted.toggle()
        onUpdate(task)
    }
}
