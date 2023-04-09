//
//  MsgBtnsView.swift
//  Mirror
//
//  Created by Ziqian Wang on 3/5/23.
//  Modified by [Your Name] on [Date]
//

import SwiftUI

struct MsgBtnsView: View {
    
    @EnvironmentObject var chatHelper: ChatHelper
    @ObservedObject private var keyboard = KeyboardResponder()
    
    @Binding var hintClicked: Bool
    @Binding var answerClicked: Bool
    @Binding var questionClicked: Bool
    @State var isHintClicked: Bool = false
    @State var isAnswerClicked: Bool = false
    @State var isPlusClicked: Bool = false
    
    @Binding var showButtons: Bool
    @Binding var loading: Bool

    var body: some View {
        
        HStack{
            
            HStack{
                //hint
                VStack (alignment: .center){
                    Image("hint")
                        .resizable()
                        .scaledToFit()
                        .frame(width:40) // Set the width of the image to match the width of VStack
                        .padding(10)
                }
                .background(isHintClicked ? Color.gray : Color("Purple3"))
                .frame(width: 40, height:40)
                .cornerRadius(20)
                .onTapGesture {
                    print("give me a hint")
                    hint()
                    isHintClicked = true
                }
                .disabled(isHintClicked)
                
                //answer
                VStack (alignment: .center){
                    Image("answer")
                        .resizable()
                        .scaledToFit()
                        .frame(width:40) // Set the width of the image to match the width of VStack
                        .padding(10)
                }
                .background(isAnswerClicked ? Color.gray : Color("Purple3"))
                .frame(width: 40, height:40)
                .cornerRadius(20)
                .onTapGesture {
                    print("example answer")
                    answer()
                    isAnswerClicked = true
                }
                .disabled(isAnswerClicked)
                
            }
            
            //plus
            HStack (alignment: .center){
                Image("plus")
                    .resizable()
                    .scaledToFit()
                    .frame(width:40) // Set the width of the image to match the width of VStack
                    .padding(10)
            }
            .background(Color("Purple3"))
            .frame(width:40, height:40)
            .cornerRadius(20)
            .onTapGesture {
                print("new question")
                question()
                isPlusClicked = true
                isAnswerClicked = false
                isHintClicked = false
            }
        }
        
    }
    
    func hint() {
        
        loading = true
        DispatchQueue.global(qos: .background).async {
            chatHelper.sendMessage(Message(display:"give me a hint", content: "give me a hint to the interview question you just asked, keep it relatively short", user: DataSource.secondUser, fromAPI: false))

            DispatchQueue.main.async {
                loading = false
            }
        }
        
        hintClicked = true
        showButtons = false
        print(showButtons)
    }
    
    func answer() {
        loading = true
        DispatchQueue.global(qos: .background).async {
            chatHelper.sendMessage(Message(display:"example answer", content: "give me a standard answer to the interview question you just asked", user: DataSource.secondUser, fromAPI: false))

            DispatchQueue.main.async {
                loading = false
            }
        }
        answerClicked = true
        showButtons = false
        print(showButtons)
        
    }
    
    func question() {
        loading = true
        DispatchQueue.global(qos: .background).async {
            FirebaseManager.shared.startNewQuestion(job: "", question: currentQues, answer: currentAns, score: currentScore)
            
            chatHelper.sendMessage(Message(display:"new question", content:  "Ask me 1 " + String(ConfigParam["company"] ?? "general") + " " + String(ConfigParam["type"] ?? "") + "interview question for a " + String(ConfigParam["position"] ?? "") + " job, keep the question short and with the question only.", user: DataSource.secondUser, fromAPI: false))

            DispatchQueue.main.async {
                loading = false
            }
        }
        hintClicked = false
        answerClicked = false
        showButtons = false
        print(showButtons)
    
        
        
    }
}

