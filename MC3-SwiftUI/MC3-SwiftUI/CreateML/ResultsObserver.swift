//
//  ResultsObserver.swift
//  MC3-SwiftUI
//
//  Created by Poppy on 23/07/20.
//  Copyright © 2020 Poppy. All rights reserved.
//

import Foundation
import SoundAnalysis
import AVFoundation

public class ResultsObserver: NSObject, SNResultsObserving {
    var delegate: SoundClassifierDelegate?
    public func request(_ request: SNRequest, didProduce result: SNResult) {
        guard let result = result as? SNClassificationResult,
            let classification = result.classifications.first else { return }
        
        let confidence = classification.confidence * 100.0
        
        if confidence > 60 {
            delegate?.displayPredictionResult(identifier: classification.identifier, confidence: confidence)
            print("identifier : \(classification.identifier) || confidence : \(confidence)")
        }
    }
}
