//
//  MessageView.swift
//

import SwiftUI

// view for user message
struct MessageView : View {
    var currentMessage: Message
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
                ContentMessageView(contentMessage: currentMessage.content,
                                   isCurrentUser: currentMessage.user.isCurrentUser)
                
                if currentMessage.fromAPI == true {
                    MsgBtnsView()
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
                ContentMessageView(contentMessage: currentMessage.content,
                                   isCurrentUser: currentMessage.user.isCurrentUser)
                
                if currentMessage.fromAPI == true {
                    MsgBtnsView()
                }
            }
            
        }.padding()
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(currentMessage: Message(content: "There are a lot of premium iOS templates on iosapptemplates.com", user: DataSource.secondUser, fromAPI: false))
    }
}
