//
//  SortingHat.swift
//  MC3-SwiftUI
//
//  Created by Reyhan Rifqi on 29/07/20.
//  Copyright © 2020 Poppy. All rights reserved.
//

import SwiftUI
import Combine

// MARK: - View that either starts Onboarding or starts the app based on UserDefaults.
struct GreatHallView: View {
    @ObservedObject var viewRouter: ViewRouter

    @ViewBuilder
    var body: some View {
        ZStack {
            if viewRouter.currentView == .onboarding {
                OnboardingView(viewRouter: ViewRouter())
                    .transition(
                        .asymmetric(insertion: .opacity, removal: .move(edge: .leading)))

            } else if viewRouter.currentView == .initial {

                // Link your initial view here. The observed object does not need to be passed to it if you don't want to revisit onboarding.
                contentRoot()
                    .transition(
                        .asymmetric(insertion: .move(edge:. trailing), removal: .opacity))
            } else {
                EmptyView()
            }
        }.animation(.spring())
    }
}

// MARK: - Logic for how views are chosen and UserDefaults are saved.



// Root views to choose between.

