import SwiftUI

struct ContentView: View {
    @StateObject private var taskStore = TaskStore()
    @State private var showingAddTask = false
    @State private var selectedFilter: TaskFilter = .all
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("Background")
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    TaskFilterView(selectedFilter: $selectedFilter)
                        .padding(.horizontal)
                    
                    if filteredTasks.isEmpty {
                        EmptyStateView()
                    } else {
                        ScrollView {
                            LazyVStack(spacing: 16) {
                                ForEach(filteredTasks) { task in
                                    TaskRowView(task: task) { updatedTask in
                                        taskStore.updateTask(updatedTask)
                                    } onDelete: {
                                        taskStore.deleteTask(task)
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }
            }
            .navigationTitle("Time Tidy")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddTask = true }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                            .foregroundColor(.accentColor)
                    }
                }
            }
            .sheet(isPresented: $showingAddTask) {
                AddTaskView { task in
                    taskStore.addTask(task)
                }
            }
        }
    }
    
    private var filteredTasks: [Task] {
        switch selectedFilter {
        case .all:
            return taskStore.tasks
        case .today:
            return taskStore.tasks.filter { Calendar.current.isDateInToday($0.dueDate) }
        case .upcoming:
            return taskStore.tasks.filter { !Calendar.current.isDateInToday($0.dueDate) }
        case .completed:
            return taskStore.tasks.filter { $0.isCompleted }
        }
    }
}