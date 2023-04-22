
//
//  ContentView.swift
//

import SwiftUI

// view for AI interview room
struct ChatView: View {
        
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    
    @State var typingMessage: String = ""
    @EnvironmentObject var chatHelper: ChatHelper
    @ObservedObject private var keyboard = KeyboardResponder()
    @State var isRecording:Bool = false
    @State var myRecognizer:recognizer!
    
    @State var hintClicked: Bool = false
    @State var answerClicked: Bool = false
    @State var questionClicked: Bool = false
    
    @State var loading: Bool = false
    
    @State private var timeRemaining = -1
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
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
                                            // Only display MessageView if the message content is not empty
                                            if !msg.content.isEmpty {
                                                MessageView(currentMessage: msg, hintClicked: $hintClicked, answerClicked: $answerClicked, questionClicked: $questionClicked, loading: $loading)
                                                    .onTapGesture(){
                                                        VoiceOver.shared.speak(msg.content.replacingOccurrences(of: "\n", with: " "))
                                                    }
                                            }
                    }
                }
                .frame(width: UIScreen.main.bounds.width)
                
                HStack {
                    Button(action: {
                        // if currently recording, end and send
                        if isRecording {
                            timeRemaining = -1
                            loading = true
                            DispatchQueue.global(qos: .background).async {
                                chatHelper.sendMessage(Message(content: myRecognizer.getCurrentTranscript(), user: DataSource.secondUser, fromAPI: false))

                                DispatchQueue.main.async {
                                    loading = false
                                }
                            }
                            self.isRecording = false
                            myRecognizer.audioEngine.stop()
                            
                        } else {
                            // if not recording, start recording
                            timeRemaining = 45
                            myRecognizer = recognizer()
                            do {
                                myRecognizer.getPermission()
                                try myRecognizer.startRecording()
                            } catch {
                                print(error)
                            }
                            self.isRecording = true
                        }
                    }) {
                        HStack {
                            if isRecording{
                                Text("Time: \(timeRemaining)").onReceive(timer) { time in
                                    if timeRemaining > 0 {
                                        timeRemaining -= 1
                                    }else if timeRemaining == 0{
                                        timeRemaining = -1
                                        loading = true
                                        DispatchQueue.global(qos: .background).async {
                                            chatHelper.sendMessage(Message(content: myRecognizer.getCurrentTranscript(), user: DataSource.secondUser, fromAPI: false))
                                            
                                            DispatchQueue.main.async {
                                                loading = false
                                            }
                                        }
                                        isRecording = false
                                        myRecognizer.audioEngine.stop()
                                    }
                                }
                            }else{
                                Image(systemName: isRecording ? "mic.fill" : "mic.slash.fill")
                                    .foregroundColor(isRecording ? .white : Color("Grey4"))
                            }
                           
                        }
                        .padding()
                        .frame(minWidth:350, minHeight: 40)
                        .background(isRecording ? Color("Purple3") : Color("Grey1"))
                        .cornerRadius(40)
                    }

                    
                    // populate textbox with real time typing input from keyboard
//                    TextField("Message...", text: $typingMessage)
//                        .textFieldStyle(RoundedBorderTextFieldStyle())
//                        .frame(minHeight: CGFloat(30))
//
//                    Button(action: sendMessage) {
//                        Image("send")
//                            .resizable()
//                            .scaledToFit()
//                            .padding(12)
//                    }
//                    .frame(width: 60, height:40)
//                    .background(Color("Grey1"))
//                    .cornerRadius(20)
                    
                }.frame(minHeight: CGFloat(50)).padding()
            }
            .navigationBarTitle(Text(DataSource.firstUser.name), displayMode: .inline)
            .padding(.bottom, keyboard.currentHeight)
            .edgesIgnoringSafeArea(keyboard.currentHeight == 0.0 ? .leading: .bottom)
            
        }.onTapGesture {
                self.endEditing(true)
        }.onAppear {
            chatHelper.clearMessages()
            chatHelper.configureChatroom(ConfigParam)
        }.onDisappear{
            if currentQues.trimmingCharacters(in: [" "]).count > 0{
                FirebaseManager.shared.startNewQuestion(job: "", question: currentQues, answer: currentAns, score: currentScore)
            }
            if myRecognizer != nil {
                myRecognizer.audioEngine.stop()
            }
            
        }.overlay(
            LoadingView(loading: loading)
        ).navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            self.presentationMode.wrappedValue.dismiss()
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Text("Back")
                .fontWeight(.bold)
                .foregroundColor(Color("Purple3"))
        })
        
    }
    
    
    func sendMessage() {
        chatHelper.sendMessage(Message(content: typingMessage, user: DataSource.secondUser, fromAPI: false))
        typingMessage = ""
        hintClicked = false
        answerClicked = false
        questionClicked = false
    }
    
    
}

//struct ChatView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChatView()
//    }
//}
