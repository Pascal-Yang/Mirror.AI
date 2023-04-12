//
//  DataView.swift
//  Mirror
//
//  Created by Zhiyi Tang on 4/7/23.
//  Copyright © 2023 Duy Bui. All rights reserved.
//

import Foundation
import SwiftUI

struct DataView : View {
    @State var loading: Bool = false
    @State private var convView: ConversationScrollView = ConversationScrollView(conversations: [])

    var body : some View{

        // TODO: fetch from storage instead of using dummy
        
        ZStack{
            convView
                .onAppear(){
                    
                    print(globalQuestionList)

                    //convView = ConversationScrollView(conversations: globalQuestionList)
                    
                    loading = true
                    FirebaseManager.shared.getQuestionsWithCallBack{result in
                        globalQuestionList = result
                        convView = ConversationScrollView(conversations: globalQuestionList)
                        loading = false
                    }
//                    DispatchQueue.global(qos: .background).async {
//                        FirebaseManager.shared.getQuestionsOfUser()
//                        sleep(3)
//                        DispatchQueue.main.async {
//                            convView = ConversationScrollView(conversations: questionList)
//                            globalQuestionList = questionList
//                            loading = false
//                        }
//                    }
                    
                    //        ConversationBarChartView(conversations: DummyConversationData.conversations)

                }
                .onDisappear(){
                    questionList = []
                }
            
            LoadingView(loading: loading)
        }
    }
    
}
