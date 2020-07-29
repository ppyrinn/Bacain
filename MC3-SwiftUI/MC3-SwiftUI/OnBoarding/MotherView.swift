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
            if viewRouter.currentView == "onboardingView" {
                OnboardingView(viewRouter: viewRouter)
                    .transition(
                        .asymmetric(insertion: .opacity, removal: .move(edge: .leading)))

            } else if viewRouter.currentView == "homeView" {
                contentRoot()
                    .transition(
                        .asymmetric(insertion: .move(edge:. trailing), removal: .opacity))
            }
        }.animation(.spring())
    }
}

struct MotherView_Previews: PreviewProvider {
    static var previews: some View {
        MotherView(viewRouter: ViewRouter()).environmentObject(ViewRouter())
    }
}

