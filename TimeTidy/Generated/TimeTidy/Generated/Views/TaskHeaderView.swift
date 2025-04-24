import SwiftUI

struct TaskHeaderView: View {
    let totalTasks: Int
    let completedTasks: Int
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Total Tasks")
                        .font(.headline)
                        .foregroundColor(.primary)
                    Text("\(totalTasks)")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    Text("Completed")
                        .font(.headline)
                        .foregroundColor(.primary)
                    Text("\(completedTasks)")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.green)
                }
            }
            .padding()
            .background(Color(.secondarySystemBackground))
            .cornerRadius(12)
            
            if totalTasks > 0 {
                VStack(spacing: 8) {
                    ProgressView(value: Double(completedTasks), total: Double(totalTasks))
                        .tint(.green)
                    
                    Text("\(Int((Double(completedTasks) / Double(totalTasks)) * 100))% Complete")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal)
            }
        }
    }
}