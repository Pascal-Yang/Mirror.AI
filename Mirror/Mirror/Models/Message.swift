//
//  Message.swift
//  ChatViewTutorial
//

import Foundation

struct Message: Hashable {
    var content: String
    var user: User
}

struct DataSource {
    static let firstUser = User(name: "Mirror", avatar: "mirror")
    static var secondUser = User(name: "Elyse Tang", avatar: "myAvatar", isCurrentUser: true)
    static let messages = [
        Message(content: "Hello there! I am Mirror, your AI Interviewer!", user: DataSource.firstUser)
    ]
}
