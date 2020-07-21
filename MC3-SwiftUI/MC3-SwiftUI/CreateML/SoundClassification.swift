//
//  SoundClassification.swift
//  MC3-SwiftUI
//
//  Created by Poppy on 21/07/20.
//  Copyright © 2020 Poppy. All rights reserved.
//

import Foundation
import Speech
import SoundAnalysis
import Combine
import AVFoundation

public class SoundClassification{
    let audioEngine = AVAudioEngine()
    let speechRecognizer: SFSpeechRecognizer? = SFSpeechRecognizer(locale: Locale.init(identifier: "id"))
    let request = SFSpeechAudioBufferRecognitionRequest()
    var recognitionTask: SFSpeechRecognitionTask?
    
    public var resultString : String = ""
    
    public func recordAndRecognizeSpeech(){
        let node = audioEngine.inputNode
        let recordingFormat = node.outputFormat(forBus : 0)
        node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat){
            buffer, _ in self.request.append(buffer)
        }
        
        audioEngine.prepare()
        do {
            try audioEngine.start()
        } catch {
            return print(error)
        }
        
        guard let myRecognizer = SFSpeechRecognizer() else { return print("recognition is not supported for the current locale") }
        if !myRecognizer.isAvailable{
            return print("recognizer is not available right now")
        }
        
        recognitionTask = speechRecognizer?.recognitionTask(with: request, resultHandler: { result, error in
            if let result = result{
                let bestString = result.bestTranscription.formattedString
                self.resultString = bestString
                print("best string = " + bestString)
            }else if let error = error{
                print(error)
            }
            
        })
    }
    
    public func stopRecording() -> String{
        audioEngine.stop()
        print("recording is stopped")
        return resultString
    }
}

