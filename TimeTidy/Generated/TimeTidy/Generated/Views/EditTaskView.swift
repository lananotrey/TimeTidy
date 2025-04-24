import SwiftUI

struct EditTaskView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var title: String
    @State private var description: String
    @State private var priority: PriorityLevel
    @State private var dueDate: Date
    @State private var isCompleted: Bool
    
    let task: TaskItem
    let onUpdate: (TaskItem) -> Void
    let onComplete: () -> Void
    
    init(task: TaskItem, onUpdate: @escaping (TaskItem) -> Void, onComplete: @escaping () -> Void) {
        self.task = task
        self.onUpdate = onUpdate
        self.onComplete = onComplete
        _title = State(initialValue: task.title)
        _description = State(initialValue: task.description)
        _priority = State(initialValue: task.priority)
        _dueDate = State(initialValue: task.dueDate)
        _isCompleted = State(initialValue: task.isCompleted)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Task Details")) {
                    TextField("Title", text: $title)
                    TextEditor(text: $description)
                        .frame(height: 100)
                }
                
                Section(header: Text("Priority")) {
                    Picker("Priority", selection: $priority) {
                        ForEach(PriorityLevel.allCases, id: \.self) { priority in
                            Text(priority.rawValue)
                                .tag(priority)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section(header: Text("Due Date")) {
                    DatePicker("Due Date", selection: $dueDate, in: Date()...)
                }
                
                Section {
                    Toggle("Mark as Completed", isOn: $isCompleted)
                }
            }
            .navigationTitle("Edit Task")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        let updatedTask = TaskItem(
                            id: task.id,
                            title: title,
                            description: description,
                            priority: priority,
                            dueDate: dueDate,
                            isCompleted: isCompleted
                        )
                        onUpdate(updatedTask)
                        onComplete()
                        dismiss()
                    }
                    .disabled(title.isEmpty)
                }
            }
        }
    }
}