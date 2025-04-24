import SwiftUI

struct PrivacyPolicyView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Privacy Policy")
                    .font(.largeTitle)
                    .bold()
                    .padding(.bottom, 8)
                
                Group {
                    Text("Last updated: \(Date().formatted(date: .long, time: .omitted))")
                        .foregroundColor(.secondary)
                    
                    Text("Information Collection and Use")
                        .font(.headline)
                    Text("We collect information that you provide directly to us when you use our app. This includes tasks and settings that you create within the app. This information is stored locally on your device and is not transmitted to our servers.")
                    
                    Text("Data Storage")
                        .font(.headline)
                    Text("All your tasks and preferences are stored locally on your device. We do not collect, store, or transmit your personal data to external servers.")
                    
                    Text("Third-Party Services")
                        .font(.headline)
                    Text("Our app does not use any third-party services that collect information about you.")
                    
                    Text("Changes to This Policy")
                        .font(.headline)
                    Text("We may update our Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page.")
                    
                    Text("Contact Us")
                        .font(.headline)
                    Text("If you have any questions about this Privacy Policy, please contact us.")
                }
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}