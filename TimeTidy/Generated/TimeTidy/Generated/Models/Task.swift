import Foundation

struct TaskItem: Identifiable, Codable {
    var id: UUID
    var title: String
    var description: String
    var priority: PriorityLevel
    var dueDate: Date
    var isCompleted: Bool
    
    init(id: UUID = UUID(), title: String, description: String, priority: PriorityLevel, dueDate: Date, isCompleted: Bool = false) {
        self.id = id
        self.title = title
        self.description = description
        self.priority = priority
        self.dueDate = dueDate
        self.isCompleted = isCompleted
    }
}

enum PriorityLevel: String, Codable, CaseIterable {
    case low = "Low"
    case medium = "Medium"
    case high = "High"
    
    var color: String {
        switch self {
        case .low: return "PriorityLow"
        case .medium: return "PriorityMedium"
        case .high: return "PriorityHigh"
        }
    }
}

enum FilterType: String, CaseIterable {
    case all = "All"
    case today = "Today"
    case upcoming = "Upcoming"
    case completed = "Completed"
}