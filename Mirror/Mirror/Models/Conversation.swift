//
//  Conversation.swift
//  Mirror
//
//  Created by Zhiyi Tang on 4/7/23.
//  Copyright © 2023 Duy Bui. All rights reserved.
//

import Foundation

var globalQuestionList : [Conversation] = []

struct Conversation : Identifiable {
    var id = UUID()
    let question: String
    let score: Int
    let answer: String
    let time: Date
}

struct DummyConversationData {
    static let conversations: [Conversation] = {
        var array: [Conversation] = []
        let calendar = Calendar.current
        let dateComponents = DateComponents(day: -7)
        let startDate = calendar.date(byAdding: dateComponents, to: Date())!
        for i in 0..<10 {
            let randomTimeInterval = TimeInterval.random(in: 0...604800) // 7 days in seconds
            let conversationTime = Date(timeIntervalSinceNow: -randomTimeInterval)
            let conversation = Conversation(question: "question\(i)", score: Int.random(in: 0...10), answer: "answer\(i)", time: conversationTime)
            array.append(conversation)
        }
        return array
    }()
}

extension Conversation: Hashable {
    static func == (lhs: Conversation, rhs: Conversation) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

func countConversationsToday(conversations: [Conversation]) -> Int {
    let today = Calendar.current.startOfDay(for: Date())
    let filteredConversations = conversations.filter {
        Calendar.current.startOfDay(for: $0.time) == today
    }
    return filteredConversations.count
}

