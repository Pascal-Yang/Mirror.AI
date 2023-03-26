//
//  Message.swift
//  ChatViewTutorial
//

import Foundation


struct Question: Hashable{
    let job:String
    let question:String
    var history:[History]
}

struct History: Hashable{
    var content:String
    var role:String
}

struct ChatRecord: Hashable{
    var content: String
    
    // 0 => user
    // 1 => chat bot
    var type: Int
    
    var time: Date
}

struct Message: Hashable {
    var display: String
    var content: String
    var user: User
    var fromAPI: Bool
    
    init(display: String? = nil, content: String, user: User, fromAPI: Bool) {
        self.display = display ?? content
        self.content = content
        self.user = user
        self.fromAPI = fromAPI
    }
}

struct DataSource {
    static let firstUser = User(name: "Mirror", avatar: "mirror")
    static var secondUser = User(name: "User", avatar: "myAvatar", isCurrentUser: true)
    static let messages = [
        Message(content: "Hello there! I am Mirror, your AI Interviewer!", user: DataSource.firstUser, fromAPI:false)
    ]
}
