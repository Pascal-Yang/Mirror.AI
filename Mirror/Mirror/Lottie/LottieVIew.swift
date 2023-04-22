//
//  LottieVIew.swift
//  Mirror
//
//  Created by Zhiyi Tang on 4/21/23.
//  Copyright © 2023 Duy Bui. All rights reserved.
//
//
import Foundation
import SwiftUI
import Lottie

struct LottieView:UIViewRepresentable {
    let name: String
    let loopMode: LottieLoopMode
    
    func makeUIView(context: Context) -> Lottie.LottieAnimationView {
        let animationView = LottieAnimationView(name: name)
        animationView.loopMode = loopMode
        animationView.play()
        return animationView
    }
    
    func updateUIView(_ uiView: Lottie.LottieAnimationView, context: Context) {
        
    }
    

    
}
