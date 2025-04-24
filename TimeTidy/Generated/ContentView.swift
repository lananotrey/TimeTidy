import SwiftUI

struct ContentView: View {
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding: Bool = false
    @StateObject private var taskStore = TaskStore()
    @State private var showingAddTask = false
    @State private var selectedFilter: FilterType = .all
    @State private var selectedTask: TaskItem?
    @State private var showingEditTask = false
    @State private var showingShareSheet = false
    @State private var selectedTab = 0
    @State private var showingSuccessNotification = false
    @State private var notificationMessage = ""
    
    var body: some View {
        Group {
            if !hasCompletedOnboarding {
                OnboardingView()
            } else {
                TabView(selection: $selectedTab) {
                    NavigationView {
                        ZStack {
                            Color(.systemBackground)
                                .ignoresSafeArea()
                            
                            VStack(spacing: 20) {
                                TaskHeaderView(
                                    totalTasks: taskStore.items.count,
                                    completedTasks: taskStore.items.filter(\.isCompleted).count
                                )
                                .padding(.horizontal)
                                
                                TaskFilterView(selectedFilter: $selectedFilter)
                                    .padding(.horizontal)
                                
                                if filteredItems.isEmpty {
                                    EmptyStateView()
                                        .transition(.opacity)
                                } else {
                                    ScrollView {
                                        LazyVStack(spacing: 16) {
                                            ForEach(filteredItems) { item in
                                                TaskRowView(
                                                    task: item,
                                                    onUpdate: { updatedItem in
                                                        taskStore.updateItem(updatedItem)
                                                    },
                                                    onDelete: {
                                                        withAnimation {
                                                            taskStore.deleteItem(item)
                                                            notificationMessage = "Task deleted successfully!"
                                                            showingSuccessNotification = true
                                                        }
                                                    },
                                                    onEditComplete: {
                                                        notificationMessage = "Task updated successfully!"
                                                        showingSuccessNotification = true
                                                    }
                                                )
                                                .contextMenu {
                                                    Button(action: {
                                                        selectedTask = item
                                                        showingEditTask = true
                                                    }) {
                                                        Label("Edit", systemImage: "pencil")
                                                    }
                                                    
                                                    Button(action: {
                                                        selectedTask = item
                                                        showingShareSheet = true
                                                    }) {
                                                        Label("Share", systemImage: "square.and.arrow.up")
                                                    }
                                                    
                                                    Button(role: .destructive, action: {
                                                        taskStore.deleteItem(item)
                                                        notificationMessage = "Task deleted successfully!"
                                                        showingSuccessNotification = true
                                                    }) {
                                                        Label("Delete", systemImage: "trash")
                                                    }
                                                }
                                                .transition(.scale.combined(with: .opacity))
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
                                withAnimation {
                                    taskStore.addItem(item)
                                    notificationMessage = "Task added successfully!"
                                    showingSuccessNotification = true
                                }
                            }
                        }
                        .sheet(isPresented: $showingEditTask) {
                            if let task = selectedTask {
                                EditTaskView(
                                    task: task,
                                    onUpdate: { updatedTask in
                                        taskStore.updateItem(updatedTask)
                                    },
                                    onComplete: {
                                        notificationMessage = "Task updated successfully!"
                                        showingSuccessNotification = true
                                    }
                                )
                            }
                        }
                        .sheet(isPresented: $showingShareSheet) {
                            if let task = selectedTask {
                                ShareSheet(items: [
                                    "Task: \(task.title)\nDescription: \(task.description)\nDue Date: \(task.dueDate.formatted())\nPriority: \(task.priority.rawValue)"
                                ])
                            }
                        }
                        .overlay(
                            NotificationBanner(
                                isPresented: $showingSuccessNotification,
                                message: notificationMessage
                            )
                        )
                    }
                    .tabItem {
                        Image(systemName: "checklist")
                        Text("Tasks")
                    }
                    .tag(0)
                    
                    SettingsView()
                        .tabItem {
                            Image(systemName: "gear")
                            Text("Settings")
                        }
                        .tag(1)
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