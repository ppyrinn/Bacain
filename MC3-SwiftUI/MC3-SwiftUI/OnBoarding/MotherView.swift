//
//  MotherView.swift
//  MC3-SwiftUI
//
//  Created by Reyhan Rifqi on 27/07/20.
//  Copyright © 2020 Poppy. All rights reserved.
//

import SwiftUI

struct MotherView: View {
    @ObservedObject var viewRouter: ViewRouter
    
    var body: some View {
        VStack {
            if viewRouter.currentPage == "onboardingView" {
                OnboardingView(viewRouter: viewRouter)
            } else if viewRouter.currentPage == "homeView" {
                contentRoot()
            }
        }
    }
}

struct MotherView_Previews: PreviewProvider {
    static var previews: some View {
        MotherView(viewRouter: ViewRouter()).environmentObject(ViewRouter())
    }
}
