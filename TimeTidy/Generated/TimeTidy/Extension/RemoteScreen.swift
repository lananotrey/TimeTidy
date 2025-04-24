import SwiftUI
import Firebase
import WebKit

struct RemoteScreenView: View {
    @StateObject private var remoteViewModel = RemoteViewModel()
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some View {
        mainContent
            .onAppear(perform: handleOnAppear)
            .onChange(of: scenePhase) { _, newPhase in
                if newPhase == .active {
                    AppRatingManager.shared.checkAndRequestReview()
                }
            }
    }
    
    @ViewBuilder
    private var mainContent: some View {
        Group {
            if remoteViewModel.currentState == .main {
                ContentView()
            } else {
                serviceContent
            }
        }
    }
    
    @ViewBuilder
    private var serviceContent: some View {
        VStack {
            if remoteViewModel.hasParameter {
                Button(action: {
                    withAnimation {
                        remoteViewModel.currentState = .main
                        AppRatingManager.shared.checkAndRequestReview()
                    }
                }) {
                    Text("Agree")
                        .foregroundStyle(.white)
                        .padding(.horizontal, 32)
                        .padding(.vertical, 12)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .foregroundStyle(.black)
                        )
                }
                .padding()
            }
            
            if let finalUrl = remoteViewModel.redirectLink {
                BrowserView(url: finalUrl, viewModel: remoteViewModel)
            }
        }
    }
    
    private func handleOnAppear() {
        AppRatingManager.shared.checkAndRequestReview()
        if !LocalStorage.shared.savedLink.isEmpty {
            remoteViewModel.redirectLink = LocalStorage.shared.savedLink
            remoteViewModel.currentState = .service
        } else if LocalStorage.shared.isFirstLaunch {
            Task {
                await processFirstLaunch()
            }
        } else {
            remoteViewModel.currentState = .main
        }
    }
    
    private func processFirstLaunch() async {
        if let data = UserDefaults.standard.data(forKey: "savedTasks") {
            let decoder = JSONDecoder()
            if let tasks = try? decoder.decode([Task].self, from: data) {
                LocalStorage.shared.isFirstLaunch = false
            }
        }
        
        if let fetchedUrl = await remoteViewModel.retrieveRemoteData() {
            await MainActor.run {
                remoteViewModel.redirectLink = fetchedUrl.absoluteString
                remoteViewModel.currentState = .service
            }
        }
        LocalStorage.shared.isFirstLaunch = false
    }
}