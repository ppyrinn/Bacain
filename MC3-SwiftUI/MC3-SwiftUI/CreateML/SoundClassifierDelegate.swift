//
//  SoundClassifierDelegate.swift
//  MC3-SwiftUI
//
//  Created by Poppy on 23/07/20.
//  Copyright © 2020 Poppy. All rights reserved.
//

import Foundation
import SoundAnalysis

public protocol SoundClassifierDelegate {
    func displayPredictionResult(identifier: String, confidence: Double)
}
