import SwiftUI

struct SettingsView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    Toggle("Dark Mode", isOn: $isDarkMode)
                } header: {
                    Text("Appearance")
                }
                
                Section {
                    Button(action: rateApp) {
                        HStack {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                            Text("Rate This App")
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                        }
                    }
                    
                    Button(action: shareApp) {
                        HStack {
                            Image(systemName: "square.and.arrow.up")
                                .foregroundColor(.blue)
                            Text("Share This App")
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                        }
                    }
                } header: {
                    Text("Support")
                }
                
                Section {
                    NavigationLink(destination: PrivacyPolicyView()) {
                        HStack {
                            Image(systemName: "lock.shield")
                                .foregroundColor(.green)
                            Text("Privacy Policy")
                        }
                    }
                    
                    NavigationLink(destination: TermsOfUseView()) {
                        HStack {
                            Image(systemName: "doc.text")
                                .foregroundColor(.purple)
                            Text("Terms of Use")
                        }
                    }
                } header: {
                    Text("Legal")
                }
            }
            .navigationTitle("Settings")
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
    
    private func rateApp() {
        guard let appStoreURL = URL(string: "https://apps.apple.com/app/idYOUR_APP_ID") else { return }
        UIApplication.shared.open(appStoreURL, options: [:], completionHandler: nil)
    }
    
    private func shareApp() {
        let appURL = "https://apps.apple.com/app/idYOUR_APP_ID"
        let activityVC = UIActivityViewController(
            activityItems: [appURL],
            applicationActivities: nil
        )
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first,
           let rootVC = window.rootViewController {
            activityVC.popoverPresentationController?.sourceView = rootVC.view
            rootVC.present(activityVC, animated: true)
        }
    }
}