import SwiftUI

struct PopupView: View {
    @EnvironmentObject var chatHelper: ChatHelper
    @Binding var popupMessage: String
    @Binding var showPopup: Bool
    let sendMessage: () -> Void
    @State private var isLoading = false

    var body: some View {
        ZStack {
            // Background view with opacity 0.5
            Color.black.opacity(0.5).ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 16) {
                TextEditor(text: $popupMessage)
                    .padding(.horizontal, 16)
                    .frame(maxHeight: .infinity)
                    .background(Color.white)
                    .cornerRadius(15)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.white, lineWidth: 1)
                    )
                
                Spacer()
                
                Button(action: sendButtonTapped) {
                    Text("send")
                        .fontWeight(.semibold)
                        .padding(.vertical, 10)
                        .frame(maxWidth: .infinity)
                        .background(isLoading ? Color("Purple2") : Color("Purple3"))
                        .foregroundColor(.white)
                        .cornerRadius(15)
                }
                .frame(maxWidth: .infinity)
                .buttonStyle(PlainButtonStyle())
                .padding(.horizontal, 16)
            }
            .padding()
            .frame(width: 320, height: 260)
            .background(Color("Grey1"))
            .cornerRadius(25)
        }
        .overlay(
            LoadingView(loading: isLoading)
        )
    }
    
    private func sendButtonTapped() {
        isLoading = true
        let editedMessage = Message(content: popupMessage, user: DataSource.secondUser, fromAPI: false)
        chatHelper.sendMessage(editedMessage)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            isLoading = false
            showPopup = false
        }
    }
}
