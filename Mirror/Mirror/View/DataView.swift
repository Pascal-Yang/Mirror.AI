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
        
        ZStack{
            if DataSource.secondUser.name != "Guest" {
                
                convView
                    .onAppear(){
                        
                        print(globalQuestionList)
                        
                        loading = true
                        FirebaseManager.shared.getQuestionsWithCallBack{result in
                            globalQuestionList = result
                            convView = ConversationScrollView(conversations: globalQuestionList)
                            loading = false
                        }
                        
                        
                    }
                    .onDisappear(){
                        questionList = []
                    }
                
                LoadingView(loading: loading)
            } else {
                Text("Please log in to view")
                    .font(.caption)
                    .fontWeight(.bold)
                    .padding()
                    .foregroundColor(Color("Purple3"))
            }
        }
    }
    
}
