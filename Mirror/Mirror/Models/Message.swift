//
//  Message.swift
//  ChatViewTutorial
//

import Foundation

struct Message: Hashable {
    var content: String
    var user: User
    var fromAPI: Bool
}

struct DataSource {
    static let firstUser = User(name: "Mirror", avatar: "mirror")
    static var secondUser = User(name: "User", avatar: "myAvatar", isCurrentUser: true)
    static let messages = [
        Message(content: "Hello there! I am Mirror, your AI Interviewer!", user: DataSource.firstUser, fromAPI:false)
    ]
}
