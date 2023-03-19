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
            //record
//            VStack (alignment: .center){
//                Image("record")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width:150)
//                    .padding(10)
//            }
//            .background(Color("Purple3"))
//            .frame(width:40, height:40)
//            .cornerRadius(20)
//            .onTapGesture {
//
//            }
            
            //hint
            HStack (alignment: .center){
                Image("hint")
                    .resizable()
                    .scaledToFit()
                    .frame(width:150)
                    .padding(10)
            }
            .background(Color("Purple3"))
            .frame(width: 40, height:40)
            .cornerRadius(20)
            .padding(.trailing,20)
            .onTapGesture {
                print("hint")
                hint()
            }
            //answer
            HStack (alignment: .center){
                    Image("answer")
                        .resizable()
                        .scaledToFit()
                        .frame(width:150)
                        .padding(10)
                        .onTapGesture {
                            print("answer")
                            answer()
                        }
            }
            .background(Color("Purple3"))
            .frame(width: 40, height:40)
            .cornerRadius(20)
            .onTapGesture {
                print("hint")
                hint()
            }
        }
        
    }
    
    func hint() {
        chatHelper.sendMessage(Message(content: "give me a hint to the interview question you just asked, keep it relatively short", user: DataSource.secondUser, fromAPI: false))
    }
    func answer() {
        chatHelper.sendMessage(Message(content: "give me a standard answer to the interview question you just asked", user: DataSource.secondUser, fromAPI: false))
    }
}

struct MsgBtnsView_Previews: PreviewProvider {
    static var previews: some View {
        MsgBtnsView()
    }
}
