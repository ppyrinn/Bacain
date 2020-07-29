//
//  ViewRouter.swift
//  MC3-SwiftUI
//
//  Created by Reyhan Rifqi on 27/07/20.
//  Copyright © 2020 Poppy. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class ViewRouter: ObservableObject {

    @Published private(set) var currentView: Houses

    init() {
        guard UserDefaults.standard.bool(forKey: "didOnboard")
            else {
                currentView = .onboarding
                return
        }
        currentView = .initial
    }

    public func didOnboard() {
        UserDefaults.standard.set(true, forKey: "didOnboard")
        withAnimation {
            currentView = .initial
        }
    }

    public func redoOnboard() {
        UserDefaults.standard.set(false, forKey: "didOnboard")
        withAnimation {
            currentView = .onboarding
        }
    }
    
}

extension ViewRouter {
    enum Houses {
        case onboarding, initial
    }
}
