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

class VoiceOver{
    static let shared = VoiceOver()
    let synthesizer = AVSpeechSynthesizer()

    func speak(_ text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = 0.4
        self.synthesizer.speak(utterance)
    }
}



