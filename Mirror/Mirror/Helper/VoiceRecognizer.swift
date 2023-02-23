//
//  VoiceRecognizer.swift
//  Mirror
//
//  Created by Pascal Yang on 2/19/23.
//  Copyright © 2023 Duy Bui. All rights reserved.
//

import Foundation
import Speech

class recognizer{
    // Declare properties required for speech recognition
    public let audioEngine = AVAudioEngine()
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en_IN"))
    private var recognitionTask: SFSpeechRecognitionTask?
    private var currentTranscript:String?
    
    init() {
        getPermission()
    }
    // Func to get the current transcript
    func getCurrentTranscript()->String{
        return currentTranscript ?? ""
    }
    //Func to request permission for speech recognition
    func getPermission(){
        SFSpeechRecognizer.requestAuthorization{authStatus in
            OperationQueue.main.addOperation {
                switch authStatus {
                case .authorized:
                    print("authorised..")
                default:
                    print("none")
                }
            }
        }
    }
    // Func to start recording audio and perform speech recognition
    func startRecording() throws{
        
        recognitionTask?.cancel()
        self.recognitionTask = nil
        
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        
        let inputNode = audioEngine.inputNode
        inputNode.removeTap(onBus: 0)
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        try audioEngine.start()
        // Create recognition request
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        guard let recognitionRequest = recognitionRequest else { fatalError("Unable to create a SFSpeechAudioBufferRecognitionRequest object") }
        recognitionRequest.shouldReportPartialResults = true
        // Enable on-device recognition if supported
        if #available(iOS 13, *) {
            if speechRecognizer?.supportsOnDeviceRecognition ?? false{
                recognitionRequest.requiresOnDeviceRecognition = true
            }
        }
        // Start recognition task
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest) { result, error in
            if let result = result {
                DispatchQueue.main.async {
                    let transcribedString = result.bestTranscription.formattedString
                    print(transcribedString)
                    self.currentTranscript = transcribedString
                }
            }
            
            if error != nil {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                self.recognitionRequest = nil
                self.recognitionTask = nil
            }
        }
    }
    
}

