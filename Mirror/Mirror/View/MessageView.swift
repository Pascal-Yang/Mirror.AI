//
//  MessageView.swift
//

import SwiftUI

struct MessageView : View {
    
    var currentMessage: Message
    @Binding var hintClicked: Bool
    @Binding var answerClicked: Bool
    @Binding var questionClicked: Bool
    
    @State private var showButtons: Bool = true
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 15) {
            HStack(alignment: .bottom, spacing: 15) {
                                
                if !currentMessage.user.isCurrentUser {
                    Image(currentMessage.user.avatar)    // user avatar
                        .resizable()
                        .frame(width: 40, height: 40, alignment: .center)
                        .cornerRadius(20)
                    Text(currentMessage.user.name)
                        .font(.caption)
                } else {
                    Spacer()
                    Text(currentMessage.user.name)
                        .font(.caption)
                    Image(currentMessage.user.avatar)    // user avatar
                        .resizable()
                        .frame(width: 40, height: 40, alignment: .center)
                        .cornerRadius(20)
                
                }
                
            }
            
            if !currentMessage.user.isCurrentUser {
        
                ContentMessageView(contentMessage: currentMessage.display,
                                   isCurrentUser: currentMessage.user.isCurrentUser)
                
            } else {
                
                HStack(alignment: .bottom, spacing: 15) {
                    Spacer()
                    ContentMessageView(contentMessage: currentMessage.display,
                                       isCurrentUser: currentMessage.user.isCurrentUser)
                }
            }
            
            if currentMessage.fromAPI == true {
                MsgBtnsView(hintClicked: $hintClicked, answerClicked: $answerClicked, questionClicked: $questionClicked, isHintClicked: hintClicked, isAnswerClicked: answerClicked, isPlusClicked: questionClicked, showButtons: $showButtons)
            }
            
        }
        .padding()
    }
}
