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
        
        if let res = fetchCompletion(prompt: chatMessage.content){
            
            // Create a new chat message from the response and append it to the realTimeMessages data source
            let new = Message(content: res, user: DataSource.firstUser, fromAPI:true)
            realTimeMessages.append(new)
            didChange.send(())
            
        }
    }
    
    func configureChatroom(_ param: [String]) {
        // TODO: initiate new conversation object to be saved in database
    
        print("here")
        // if start of conversation, configure chatroom
        if realTimeMessages.count <= 1 {
            // prepare prompt
            let configuredParams = "Please ask me some interview questions one at a time based on the following parameters: " + param.joined(separator: " " + "; Keep all response relatively short please")
            print(configuredParams)

            if let res = fetchCompletion(prompt: configuredParams){
                let new = Message(content: res, user: DataSource.firstUser, fromAPI: true)
                realTimeMessages.append(new)
                didChange.send(())
            }
        }
        
        return

                
    }
    
    func endChat() {
        // TODO: terminate current chat and save conversation history
    }
}
