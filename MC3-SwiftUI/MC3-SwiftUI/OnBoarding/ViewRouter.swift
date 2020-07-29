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


    init() {
        if !UserDefaults.standard.bool(forKey: "didOnboard"){
            UserDefaults.standard.set(true, forKey: "didOnboard")

                currentView = .onboarding
        }else{
            currentView = .initial
        }
    }
    
    @Published var currentView: Houses

}

extension ViewRouter {
    enum Houses {
        case onboarding, initial
    }
}
