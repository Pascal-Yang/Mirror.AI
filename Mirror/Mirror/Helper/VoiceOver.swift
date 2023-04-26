//
//  VoiceOver.swift
//  Mirror
//
//  Created by Pascal Yang on 4/4/23.
//  Copyright © 2023 Duy Bui. All rights reserved.
//

import Foundation
import AVFoundation
import SwiftUI

class VoiceOver {
    static let shared = VoiceOver()
    private let speechSynthesizer = AVSpeechSynthesizer()
    private let audioSession = AVAudioSession.sharedInstance()
    
    func speak(_ text: String) {
        
        do {
            try audioSession.setCategory(.playback, mode: .default, options: [])
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            print("Error setting up audio session: \(error.localizedDescription)")
            return
        }
        
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = 0.4
        
        speechSynthesizer.speak(utterance)
    }
    
    func stop() {
        speechSynthesizer.stopSpeaking(at: .immediate)
    }
}


