import SwiftUI

struct NotificationBanner: View {
    @Binding var isPresented: Bool
    let message: String
    
    var body: some View {
        if isPresented {
            VStack {
                Spacer()
                Text(message)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(10)
                    .padding(.bottom, 20)
            }
            .transition(.move(edge: .bottom))
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        isPresented = false
                    }
                }
            }
        }
    }
}