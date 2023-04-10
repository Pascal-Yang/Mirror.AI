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
        var score = "0";
        
        print("evaluation process:")
        var pendingMessage = chatMessage.content
        print(pendingMessage)
        
        //If pendingMessage is one of the preset message of msgbtnsview, don't evaluate it
        if pendingMessage == "give me a hint to the interview question you just asked, keep it relatively short" ||
           pendingMessage == "give me a standard answer to the interview question you just asked" ||
            pendingMessage.contains("with the question only")  {
            
            if let res = fetchCompletion(prompt: pendingMessage){
                // Create a new chat message from the response and append it to the realTimeMessages data source
                let new = Message(content: res, user: DataSource.firstUser, fromAPI:true)
                realTimeMessages.append(new)
                didChange.send(())
            }
            
        }

        
        //If pendingMessage is a user response, evaluate it
        else{
            let evaluatePrompt = "Evaluate this answer to your question like a real interviewer and give me a score out of 10, along with 2 short advices:'" + String(pendingMessage) + "'."
            print(evaluatePrompt)

            if let res = fetchCompletion(prompt: evaluatePrompt){
                // Create a new chat message from the response and append it to the realTimeMessages data source
                print(res)
                
                var charBefore: Character = "0"
                // Extract the score from res
                if let range = res.range(of: "/10").map({ $0.lowerBound }) ?? res.range(of: " out of 10").map({ $0.lowerBound }), range != res.startIndex {
                    charBefore = res[res.index(before: range)]
                }
                
                if charBefore == "0" && res.index(before: res.endIndex) != res.startIndex {
                    let charBeforeZero = res[res.index(before: res.index(before: res.endIndex))]
                    if charBeforeZero == "1" {
                        let extractedScore = "10"
                        print("Extracted score:", extractedScore)
                        score = extractedScore
                    }
                } else {
                    let extractedScore = String(charBefore)
                    print("Extracted score:", extractedScore)
                    score = extractedScore
                    currentScore = score
                    currentAns = pendingMessage
                }
                
                let new = Message(content: res, user: DataSource.firstUser, fromAPI:true)
                realTimeMessages.append(new)
                didChange.send(())
            }
        }
        
        if Int(score) == nil {
            let defaultScore = "0"
            print("Score is not a numeric string, setting it to the default value:", defaultScore)
        }
        print("final score:", score)
    }
    
    func configureChatroom(_ param: [String:String]) {
        // TODO: initiate new conversation object to be saved in database
    
        print("here")
        // if start of conversation, configure chatroom
        var company = "general"
        if let temp = param["company"]?.lowercased() {
            company = temp
        }
        let questionType = param["type"]?.lowercased()
        let job = param["position"]?.lowercased()
//        var num = param[2].lowercased()
        
//        if questionType!.count >= 9 {
//            let endIndex = questionType!.index(questionType!.endIndex, offsetBy: -9)
//            questionType = String(questionType![..<endIndex])
//            }
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
            let configuredParams = "Ask me 1 " + String(company ) + " " + String(questionType ?? "") + "interview question for a " + String(job ?? "") + " job, keep the question short and with the question only."
            print(configuredParams)

            if let res = fetchCompletion(prompt: configuredParams){
                let new = Message(content: res, user: DataSource.firstUser, fromAPI: true)
                realTimeMessages.append(new)
                didChange.send(())
            }
        }
        
        return

                
    }
    
    func clearMessages() {
        realTimeMessages.removeAll()
    }
    
    func endChat() {
        // TODO: terminate current chat and save conversation history
    }
}
