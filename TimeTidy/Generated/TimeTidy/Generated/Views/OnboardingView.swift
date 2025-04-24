import SwiftUI

struct OnboardingView: View {
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding: Bool = false
    @State private var currentPage = 0
    
    let onboardingPages = [
        OnboardingPage(
            image: "checklist.checked",
            title: "Task Management Made Simple",
            description: "Create, organize, and track your tasks with ease. Set priorities and due dates to stay on top of your schedule."
        ),
        OnboardingPage(
            image: "chart.bar.fill",
            title: "Track Your Progress",
            description: "Monitor your task completion rate and see your productivity improve over time with detailed progress tracking."
        ),
        OnboardingPage(
            image: "bell.badge.fill",
            title: "Stay Organized",
            description: "Filter tasks by status, mark them as complete, and keep your daily activities well-organized in one place."
        )
    ]
    
    var body: some View {
        ZStack {
            Color(.systemBackground).ignoresSafeArea()
            
            VStack(spacing: 0) {
                TabView(selection: $currentPage) {
                    ForEach(0..<onboardingPages.count, id: \.self) { index in
                        OnboardingPageView(page: onboardingPages[index])
                            .tag(index)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .animation(.easeInOut, value: currentPage)
                
                Spacer()
                
                // Page indicators
                HStack(spacing: 8) {
                    ForEach(0..<onboardingPages.count, id: \.self) { index in
                        Circle()
                            .fill(index == currentPage ? Color.accentColor : Color.gray.opacity(0.3))
                            .frame(width: 8, height: 8)
                            .scaleEffect(index == currentPage ? 1.2 : 1.0)
                            .animation(.spring(), value: currentPage)
                    }
                }
                .padding(.bottom, 20)
                
                // Navigation buttons
                VStack(spacing: 16) {
                    Button(action: {
                        if currentPage < onboardingPages.count - 1 {
                            withAnimation {
                                currentPage += 1
                            }
                        } else {
                            withAnimation {
                                hasCompletedOnboarding = true
                            }
                        }
                    }) {
                        Text(currentPage < onboardingPages.count - 1 ? "Next" : "Get Started")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.accentColor)
                            .cornerRadius(12)
                    }
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 32)
            }
        }
    }
}

struct OnboardingPage: Identifiable {
    let id = UUID()
    let image: String
    let title: String
    let description: String
}

struct OnboardingPageView: View {
    let page: OnboardingPage
    
    var body: some View {
        VStack(spacing: 32) {
            Spacer()
            
            Image(systemName: page.image)
                .font(.system(size: 120))
                .foregroundColor(.accentColor)
                .padding()
                .transition(.scale.combined(with: .opacity))
            
            VStack(spacing: 16) {
                Text(page.title)
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                
                Text(page.description)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                    .padding(.horizontal, 32)
            }
            
            Spacer()
        }
        .padding()
    }
}