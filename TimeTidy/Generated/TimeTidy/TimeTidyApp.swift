import SwiftUI
import FirebaseCore
import FirebaseRemoteConfig

@main
struct TimeTidyApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            RemoteScreenView()
        }
    }
}