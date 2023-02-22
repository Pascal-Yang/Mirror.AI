//
//  ChatHelper.swift
//

import Combine

class ChatHelper : ObservableObject {
    var didChange = PassthroughSubject<Void, Never>()
    @Published var realTimeMessages = DataSource.messages
    
    func sendMessage(_ chatMessage: Message) {
        realTimeMessages.append(chatMessage)
        didChange.send(())
        if let res = fetchData(prompt: chatMessage.content){
            
            let new = Message(content: res.response, user: DataSource.firstUser)
            realTimeMessages.append(new)
            didChange.send(())
        }

        
    }
}
