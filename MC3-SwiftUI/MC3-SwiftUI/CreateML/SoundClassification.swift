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
    //Speech Recognizer
    let audioEngine = AVAudioEngine()
    let speechRecognizer: SFSpeechRecognizer? = SFSpeechRecognizer(locale: Locale.init(identifier: "id"))
    let request = SFSpeechAudioBufferRecognitionRequest()
    var recognitionTask: SFSpeechRecognitionTask?
    
    public var resultString : String = ""
    
    var isRecognitionAvailable = true
    
    //Sound Analyzer
    private var soundClassifier = MC3_SoundClassifier_2()
    var analyzer: SNAudioStreamAnalyzer!
    let analysisQueue = DispatchQueue(label: "com.poppy.MC3-SwiftUI")
    var inputFormat: AVAudioFormat!
    var resultsObserver = ResultsObserver()
    
    public func recordAndRecognizeSpeech(){
        let node = audioEngine.inputNode
        let recordingFormat = node.outputFormat(forBus : 0)
        node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat){
            buffer, _ in self.request.append(buffer)
        }
        
        //Sound Analyzer
        inputFormat = node.inputFormat(forBus: 0)
        analyzer = SNAudioStreamAnalyzer(format: inputFormat)
        
        
        audioEngine.prepare()
        do {
            try audioEngine.start()
        } catch {
            return print(error)
        }
        
        
        //Speech Recognizer
        guard let myRecognizer = SFSpeechRecognizer() else {
            print("recognition is not supported for the current locale")
            return isRecognitionAvailable = false
        }
        if !myRecognizer.isAvailable{
            print("recognizer is not available right now")
            print("sound classification")
            do {
                let request = try SNClassifySoundRequest(mlModel: soundClassifier.model)
                try analyzer.add(request, withObserver: resultsObserver)
            } catch {
                print("Unable to prepare request: \(error.localizedDescription)")
                return
            }
            //            return
        }else{
            print("speech recognition")
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
        
    }
    
    public func stopRecording() -> String{
        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0)
        self.request.endAudio()
        self.recognitionTask = nil
        print("recording is stopped")
        return resultString
    }
}

