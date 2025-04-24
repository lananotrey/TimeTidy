import SwiftUI

struct TaskHeaderView: View {
    let totalTasks: Int
    let completedTasks: Int
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Total Tasks")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Text("\(totalTasks)")
                        .font(.title)
                        .fontWeight(.bold)
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    Text("Completed")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Text("\(completedTasks)")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.green)
                }
            }
            .padding()
            .background(Color("TaskBackground"))
            .cornerRadius(12)
            
            if totalTasks > 0 {
                ProgressView(value: Double(completedTasks), total: Double(totalTasks))
                    .tint(.green)
                    .padding(.horizontal)
            }
        }
    }
}