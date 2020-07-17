//
//  contentRoot.swift
//  MC3-SwiftUI
//
//  Created by Reyhan Rifqi on 18/07/20.
//  Copyright © 2020 Poppy. All rights reserved.
//

import SwiftUI

struct contentRoot: View {
    var body: some View {
        TabView{
            ProgresifView().tabItem({
                Image(systemName: "star.fill")
                Text("Progresif")
            }).tag(0)
            FonikView().tabItem({
                Image(systemName: "star.fill")
                Text("Fonik")
            }).tag(1)
            SusunKataView().tabItem({
                Image(systemName: "star.fill")
                Text("Susun Kata")
            }).tag(2)
            
        }
    }
}

struct contentRoot_Previews: PreviewProvider {
    static var previews: some View {
        contentRoot()
    }
}
