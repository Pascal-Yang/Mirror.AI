import SwiftUI

struct PopupView: View {
    @EnvironmentObject var chatHelper: ChatHelper
    @Binding var popupMessage: String
    @Binding var showPopup: Bool
    let sendMessage: () -> Void
    @State private var isLoading = false
    @State private var isButtonDisabled = false
    @State private var isTextEditorEmpty: Bool
    @State private var showAlert = false
    @State private var isButtonPressed = false

    init(popupMessage: Binding<String>, showPopup: Binding<Bool>, sendMessage: @escaping () -> Void) {
        self._popupMessage = popupMessage
        self._showPopup = showPopup
        self.sendMessage = sendMessage
        self._isTextEditorEmpty = State(initialValue: popupMessage.wrappedValue.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
    }

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
                    .onChange(of: popupMessage) { text in
                        isTextEditorEmpty = text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
                    }
                
                Spacer()
                
                Button(action: sendButtonTapped) {
                    Text(showAlert ? "Entry cannot be empty" : "send")
                        .fontWeight(.semibold)
                        .padding(.vertical, 10)
                        .frame(maxWidth: .infinity)
                        .background(
                            showAlert ? Color.orange :
                            isButtonPressed ? Color("Purple2") :
                            Color("Purple3")
                        )
                        .foregroundColor(.white)
                        .cornerRadius(15)
                }
                .frame(maxWidth: .infinity)
                .buttonStyle(PlainButtonStyle())
                .padding(.horizontal, 16)
                .disabled(isButtonDisabled)
                .scaleEffect(showAlert ? 1.05 : 1)
                .animation(.easeInOut(duration: 0.1))
                .simultaneousGesture(LongPressGesture(minimumDuration: .infinity)
                    .onChanged { _ in isButtonPressed = true }
                    .onEnded { _ in isButtonPressed = false }
                )
            }
            .padding()
            .frame(width: 320, height: 260)
            .background(Color("Grey1"))
            .cornerRadius(25)
        }
    }
    
    private func sendButtonTapped() {
        if isTextEditorEmpty {
            showAlert = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                showAlert = false
                isButtonPressed = false // Reset the button state after the alert is dismissed
            }
        } else {
            isButtonDisabled = true
            isLoading = true
            let editedMessage = Message(content: popupMessage, user: DataSource.secondUser, fromAPI: false)
            chatHelper.sendMessage(editedMessage)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                isLoading = false
                showPopup = false
            }
        }
        
        isButtonPressed = false // Reset the button state after it is pressed
    }
}

