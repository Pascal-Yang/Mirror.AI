//
//  DataView.swift
//  Mirror
//
//  Created by Zhiyi Tang on 4/7/23.
//  Copyright © 2023 Duy Bui. All rights reserved.
//

import Foundation
import SwiftUI
//import SwiftUICharts


struct DataView : View {
    @State var loading: Bool = false
    var body : some View{
        
        
        
        
        
        // TODO: fetch from storage instead of using dummy
        
        
        ConversationScrollView(conversations: questionList)
            .onAppear(){
                loading = true
                DispatchQueue.global(qos: .background).async {
                    FirebaseManager.shared.getQuestionsOfUser()
                    sleep(3)
                    DispatchQueue.main.async {
                        loading = false
                    }
                }
        
//        ConversationBarChartView(conversations: DummyConversationData.conversations)
        
            }
            .overlay(
                LoadingView(loading: loading)
            )
    }
}

//struct ConversationBarChartView: View {
//    let conversations: [Conversation]
//
//    var body: some View {
//        let sortedConversations = conversations.sorted { $0.time > $1.time }
//        let selectedConversations = sortedConversations.prefix(7)
//        let scores = selectedConversations.map { Double($0.score) }
//        let times = selectedConversations.map { conversation in
//            let formatter = DateFormatter()
//            formatter.dateFormat = "MM/dd/yyyy"
//            return formatter.string(from: conversation.time)
//        }
//
//        return BarChartView(
//            dataPoints: scores,
//            xAxisLabels: times,
//            yAxisTitle: "Score",
//            title: "Recent Conversations"
//        )
//    }
//}
