//
//  Message.swift
//  ChatViewTutorial
//

import Foundation

struct ChatRecord: Hashable{
    var content: String
    
    // 0 => user
    // 1 => chat bot
    var type: Int
    
    var time: Date
}

struct Message: Hashable {
    var content: String
    var user: User
}

struct DataSource {
    static let firstUser = User(name: "Mirror", avatar: "mirror")
    static var secondUser = User(name: "User", avatar: "myAvatar", isCurrentUser: true)
    static let messages = [
        Message(content: "Hello there! I am Mirror, your AI Interviewer!", user: DataSource.firstUser)
    ]
}
