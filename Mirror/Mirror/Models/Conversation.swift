//
//  Conversation.swift
//  Mirror
//
//  Created by Zhiyi Tang on 4/7/23.
//  Copyright © 2023 Duy Bui. All rights reserved.
//

import Foundation

struct Conversation {
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
