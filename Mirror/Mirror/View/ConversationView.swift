//
//  ConversationView.swift
//  Mirror
//
//  Created by Zhiyi Tang on 4/9/23.
//  Copyright © 2023 Duy Bui. All rights reserved.
//

import Foundation
import SwiftUI

struct ConversationScrollView: View {
    let conversations: [Conversation]

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(conversations.sorted { $0.time > $1.time }, id: \.self) { conversation in
                    ConversationBlockView(conversation: conversation)
                }
            }
            .padding(30)
            .padding(.bottom, 100)
        }
    }
}

struct ConversationBlockView: View {
    let conversation: Conversation

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Score: \(conversation.score)")
                .font(.headline)
            Text("Date: \(Self.dateFormatter.string(from: conversation.time))")
                .foregroundColor(Color("Grey3"))
                .font(.subheadline)
            Text("Question: \(conversation.question)")
            Text("Answer: \(conversation.answer)")
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(25)
        .background(Color("Purple1"))
        .cornerRadius(25)
    }
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter
    }()
    
}
