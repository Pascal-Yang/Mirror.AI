//
//  MessageView.swift
//

import SwiftUI

struct MessageView : View {
    
    var currentMessage: Message
    @Binding var hintClicked: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            if !currentMessage.user.isCurrentUser {
                VStack(alignment: .leading, spacing: 15){
                    HStack(alignment: .center, spacing:10){
                        Image(currentMessage.user.avatar)    // user avatar
                            .resizable()
                            .frame(width: 40, height: 40, alignment: .center)
                            .cornerRadius(20)
                        Text(currentMessage.user.name)
                    }
                }
                ContentMessageView(contentMessage: currentMessage.display,
                                   isCurrentUser: currentMessage.user.isCurrentUser)
                if currentMessage.fromAPI == true {
                    MsgBtnsView(hintClicked: $hintClicked, answerClicked: .constant(false), questionClicked: .constant(false), isHintClicked: hintClicked)
                }
            } else {
                VStack(alignment: .trailing, spacing: 15){
                    HStack(alignment: .center, spacing:10){
                        Text(currentMessage.user.name)
                        Image(currentMessage.user.avatar)    // user avatar
                            .resizable()
                            .frame(width: 40, height: 40, alignment: .center)
                            .cornerRadius(20)
                    }
                }
                ContentMessageView(contentMessage: currentMessage.display,
                                   isCurrentUser: currentMessage.user.isCurrentUser)
            }
            
        }
        .padding()
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(currentMessage: Message(content: "Hello, this is a test message.", user: DataSource.firstUser, fromAPI: false), hintClicked: .constant(false))
    }
}
