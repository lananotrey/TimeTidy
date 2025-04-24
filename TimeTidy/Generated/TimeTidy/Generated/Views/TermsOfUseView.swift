import SwiftUI

struct TermsOfUseView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Terms of Use")
                    .font(.largeTitle)
                    .bold()
                    .padding(.bottom, 8)
                
                Group {
                    Text("Last updated: \(Date().formatted(date: .long, time: .omitted))")
                        .foregroundColor(.secondary)
                    
                    Text("1. Acceptance of Terms")
                        .font(.headline)
                    Text("By accessing and using this app, you accept and agree to be bound by the terms and provision of this agreement.")
                    
                    Text("2. Use License")
                        .font(.headline)
                    Text("Permission is granted to temporarily download one copy of the app for personal, non-commercial transitory viewing only.")
                    
                    Text("3. Disclaimer")
                        .font(.headline)
                    Text("The app is provided on an 'as is' basis. We make no warranties, expressed or implied, and hereby disclaim and negate all other warranties, including without limitation, implied warranties or conditions of merchantability, fitness for a particular purpose, or non-infringement of intellectual property or other violation of rights.")
                    
                    Text("4. Limitations")
                        .font(.headline)
                    Text("In no event shall we be liable for any damages arising out of the use or inability to use the app.")
                    
                    Text("5. Changes to Terms")
                        .font(.headline)
                    Text("We reserve the right to modify these terms at any time. We do so by posting and drawing attention to the updated terms on the app. Your decision to continue to visit and make use of the app after such changes have been made constitutes your formal acceptance of the new Terms of Use.")
                }
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}