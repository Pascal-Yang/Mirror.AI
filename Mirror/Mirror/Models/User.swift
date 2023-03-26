//
//  User.swift
//  ChatViewTutorial
//

import Foundation

struct User: Hashable {
    var name: String
    var avatar: String
    var isCurrentUser: Bool = false
    var quesPerDay: Int = 10
}


