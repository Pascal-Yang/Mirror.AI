//
//  LaunchScreenViewController.swift
//  Mirror
//
//  Created by Zhiyi Tang on 4/11/23.
//  Copyright © 2023 Duy Bui. All rights reserved.
//

import SwiftUI

struct LaunchScreenView: View {
    @State private var isLoginViewPresented = false
    var chatHelper = ChatHelper()
    @State var imageScale: Double = 0.5

    var body: some View {
        ZStack {
            Rectangle()
                .fill(LinearGradient(
                    gradient: Gradient(colors: [Color("Purple3"), Color.white]),
                    startPoint: .top,
                    endPoint: .center
                ))
                .edgesIgnoringSafeArea(.all)

            VStack {
                Spacer()
                
                Image("appName")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.white)
                    .scaleEffect(imageScale)
                    .onAppear {
                        withAnimation(Animation.easeInOut(duration: 1.0).repeatForever()) {
                            imageScale = 0.55
                        }
                    }
                    .padding(.top, 80)
                
                Spacer()
                                
                TypingAnimationView(text: "Introducing Mirror, the AI Interviewer App designed to help you ace your next interview! With Mirror, you can get a realistic mock practice of real interview questions, and receive real-time feedback from artificial intelligence on your performance.")
                    .padding(.bottom, 80)
                
                Text("Tap to continue")
                    .italic()
                    .foregroundColor(Color("Grey3"))
            }
            .padding(.top, 100)
            .padding(.bottom, 80)

        }
        .onTapGesture {
            withAnimation {
                isLoginViewPresented = true
            }
        }
        .fullScreenCover(isPresented: $isLoginViewPresented) {
            LoginPage().environmentObject(chatHelper)
        }
    }
}

struct TypingAnimationView: View {
    let text: String
    @State private var animatedText = ""
    @State private var currentIndex = 0
    
    var body: some View {
        Text(animatedText)
            .font(.system(size: 13))
            .foregroundColor(Color("Grey3"))
            .frame(height: 80)
            .padding(.horizontal, 40)
            .padding(.vertical, 25)
            .onAppear {
                Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
                    let index = text.index(text.startIndex, offsetBy: currentIndex)
                    animatedText += String(text[index])
                    currentIndex += 1
                    if currentIndex == text.count {
                        timer.invalidate()
                    }
                }
            }
    }
}
