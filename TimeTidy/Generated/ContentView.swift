import SwiftUI

struct ContentView: View {
    @StateObject private var taskStore = TaskStore()
    @State private var showingAddTask = false
    @State private var selectedFilter: FilterType = .all
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("Background")
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    TaskFilterView(selectedFilter: $selectedFilter)
                        .padding(.horizontal)
                    
                    if filteredItems.isEmpty {
                        EmptyStateView()
                    } else {
                        ScrollView {
                            LazyVStack(spacing: 16) {
                                ForEach(filteredItems) { item in
                                    TaskRowView(task: item) { updatedItem in
                                        taskStore.updateItem(updatedItem)
                                    } onDelete: {
                                        taskStore.deleteItem(item)
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
                AddTaskView { item in
                    taskStore.addItem(item)
                }
            }
        }
    }
    
    private var filteredItems: [TaskItem] {
        switch selectedFilter {
        case .all:
            return taskStore.items
        case .today:
            return taskStore.items.filter { Calendar.current.isDateInToday($0.dueDate) }
        case .upcoming:
            return taskStore.items.filter { !Calendar.current.isDateInToday($0.dueDate) }
        case .completed:
            return taskStore.items.filter { $0.isCompleted }
        }
    }
}