//
//  ContentView.swift
//

import SwiftUI

// view for AI interview room
struct ChatView: View {
    @State var typingMessage: String = ""
    @EnvironmentObject var chatHelper: ChatHelper
    @ObservedObject private var keyboard = KeyboardResponder()
    @State var isRecording:Bool = false
    @State var myRecognizer:recognizer!
    
    init() {
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().tableFooterView = UIView()
        myRecognizer = recognizer()
    }
    
    var body: some View {
        NavigationView {
                        
            VStack {
                
                List {
                    ForEach(chatHelper.realTimeMessages, id: \.self) { msg in
                        MessageView(currentMessage: msg)
                    }
                }
                .frame(width:.infinity)
                
                HStack {
                    
                    Button(action: {
                        
                        // if currently recording, end and send
                        if isRecording {
                            chatHelper.sendMessage(Message(content: myRecognizer.getCurrentTranscript(), user: DataSource.secondUser, fromAPI: false))
                            self.isRecording = false
                            myRecognizer.audioEngine.stop()
                        } else {
                        // if not recording, start recording
                            myRecognizer = recognizer()
                            do {
                                myRecognizer.getPermission()
                                try myRecognizer.startRecording()
                            } catch {
                                print(error)
                            }
                            self.isRecording = true
                        }
                        
                    }){
                        Image(systemName: isRecording ? "mic.fill" : "mic.slash.fill")
                    }
                    
                    // populate textbox with real time typing input from keyboard
                    TextField("Message...", text: $typingMessage)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(minHeight: CGFloat(30))
                    
                    Button(action: sendMessage) {
                        Text("Send")
                    }
                }.frame(minHeight: CGFloat(50)).padding()
            }.navigationBarTitle(Text(DataSource.firstUser.name), displayMode: .inline)
            .padding(.bottom, keyboard.currentHeight)
            .edgesIgnoringSafeArea(keyboard.currentHeight == 0.0 ? .leading: .bottom)
        }.onTapGesture {
                self.endEditing(true)
        }.onAppear {
            chatHelper.configureChatroom(ConfigParam)
        }
    }
    
    func sendMessage() {
        chatHelper.sendMessage(Message(content: typingMessage, user: DataSource.secondUser, fromAPI: false))
        typingMessage = ""
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
