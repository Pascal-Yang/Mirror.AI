//
//  MessageView.swift
//

import SwiftUI

// view for user message
struct MessageView : View {
    var currentMessage: Message
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
                MsgBtnsView()

            }
            
        }
        .padding()
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(currentMessage: Message(content: "There are a lot of premium iOS templates on iosapptemplates.com", user: DataSource.secondUser, fromAPI: false))
    }
}
