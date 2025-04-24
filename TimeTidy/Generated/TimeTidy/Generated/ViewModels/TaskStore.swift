import Foundation

class TaskStore: ObservableObject {
    @Published var items: [TaskItem] = []
    private let tasksKey = "savedTasks"
    
    init() {
        loadItems()
    }
    
    func addItem(_ item: TaskItem) {
        items.append(item)
        saveItems()
    }
    
    func updateItem(_ item: TaskItem) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index] = item
            saveItems()
        }
    }
    
    func deleteItem(_ item: TaskItem) {
        items.removeAll { $0.id == item.id }
        saveItems()
    }
    
    private func saveItems() {
        if let encoded = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encoded, forKey: tasksKey)
        }
    }
    
    private func loadItems() {
        if let data = UserDefaults.standard.data(forKey: tasksKey),
           let decoded = try? JSONDecoder().decode([TaskItem].self, from: data) {
            items = decoded
        }
    }
}