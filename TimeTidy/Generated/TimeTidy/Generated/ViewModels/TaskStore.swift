import Foundation

class TaskStore: ObservableObject {
    @Published var tasks: [TaskTask] = []
    private let tasksKey = "savedTasks"
    
    init() {
        loadTasks()
    }
    
    func addTask(_ task: TaskTask) {
        tasks.append(task)
        saveTasks()
    }
    
    func updateTask(_ task: TaskTask) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index] = task
            saveTasks()
        }
    }
    
    func deleteTask(_ task: TaskTask) {
        tasks.removeAll { $0.id == task.id }
        saveTasks()
    }
    
    private func saveTasks() {
        if let encoded = try? JSONEncoder().encode(tasks) {
            UserDefaults.standard.set(encoded, forKey: tasksKey)
        }
    }
    
    private func loadTasks() {
        if let data = UserDefaults.standard.data(forKey: tasksKey),
           let decoded = try? JSONDecoder().decode([TaskTask].self, from: data) {
            tasks = decoded
        }
    }
}