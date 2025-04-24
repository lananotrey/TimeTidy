import SwiftUI

struct TaskRowView: View {
    @State private var item: TaskItem
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
                
                Button(action: onDelete) {
                    Image(systemName: "trash")
                        .foregroundColor(.red)
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
    }
    
    private func toggleCompletion() {
        item.isCompleted.toggle()
        onUpdate(item)
    }
}