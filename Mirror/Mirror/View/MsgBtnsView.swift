//
//  MsgBtnsView.swift
//  Mirror
//
//  Created by Ziqian Wang on 3/5/23.
//  Copyright © 2023 Duy Bui. All rights reserved.
//

import SwiftUI

struct MsgBtnsView: View {
    @EnvironmentObject var chatHelper: ChatHelper
    @ObservedObject private var keyboard = KeyboardResponder()
    @State var isRecording:Bool = false
    @State var myRecognizer:recognizer!
    
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
                .background(Color("Purple3"))
                .frame(width: 40, height:40)
                .cornerRadius(20)
                .onTapGesture {
                    print("give me a hint")
                    hint()
                }
                //answer
                VStack (alignment: .center){
                    Image("answer")
                        .resizable()
                        .scaledToFit()
                        .frame(width:40) // Set the width of the image to match the width of VStack
                        .padding(10)
                }
                .background(Color("Purple3"))
                .frame(width: 40, height:40)
                .cornerRadius(20)
                .onTapGesture {
                    print("example answer")
                    answer()
                }
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
                answer()
            }
        }
        
    }
    
    func hint() {
        chatHelper.sendMessage(Message(display:"give me a hint", content: "give me a hint to the interview question you just asked, keep it relatively short", user: DataSource.secondUser, fromAPI: false))
    }
    func answer() {
        chatHelper.sendMessage(Message(display:"example answer", content: "give me a standard answer to the interview question you just asked", user: DataSource.secondUser, fromAPI: false))
    }
    func question() {
        chatHelper.sendMessage(Message(display:"new question", content: "give me another question", user: DataSource.secondUser, fromAPI: false))
    }
}

struct MsgBtnsView_Previews: PreviewProvider {
    static var previews: some View {
        MsgBtnsView()
    }
}

