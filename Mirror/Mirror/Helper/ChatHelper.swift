//
//  ChatHelper.swift
//

import Combine

class ChatHelper : ObservableObject {
    var didChange = PassthroughSubject<Void, Never>()
    @Published var realTimeMessages = DataSource.messages
    // Define a function named sendMessage which appends the new chat message to the realTimeMessages data source
    func sendMessage(_ chatMessage: Message) {
        realTimeMessages.append(chatMessage)
        didChange.send(())
        //If the response from the fetchData function is not nil,
        if let res = fetchData(prompt: chatMessage.content){
            // Create a new chat message from the response and append it to the realTimeMessages data source
            let new = Message(content: res.response, user: DataSource.firstUser)
            realTimeMessages.append(new)
            didChange.send(())
        }

        
    }
}
