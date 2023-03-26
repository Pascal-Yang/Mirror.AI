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
        let company = param[0].lowercased()
        var questionType = param[1].lowercased()
        let job = param[2].lowercased()
//        var num = param[2].lowercased()
        
        if questionType.count >= 9 {
                let endIndex = questionType.index(questionType.endIndex, offsetBy: -9)
            questionType = String(questionType[..<endIndex])
            }
//        if (num.count >= 8 && num.count <= 10){
//                let endIndex = num.index(num.endIndex, offsetBy: -8)
//            num = String(num[..<endIndex])
//            }
//        if (num.count > 10){
//                let endIndex = num.index(num.endIndex, offsetBy: -9)
//            num = String(num[..<endIndex])
//            }
        
        if realTimeMessages.count <= 1 {
            // prepare prompt
            let configuredParams = "Ask me 1 " + company + " " + questionType + "interview question for a " + job + " job, keep the question short."
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
