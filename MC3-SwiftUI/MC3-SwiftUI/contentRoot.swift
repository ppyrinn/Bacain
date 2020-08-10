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
                Image("Progresif ga aktif")
                    .renderingMode(.template)
                Text("Progresif")
            }).tag(0)
            FonikView().tabItem({
                Image("Fonik ga aktif")
                .renderingMode(.template)
                Text("Fonik")
            }).tag(1)
            SusunKataView().tabItem({
                Image("Susun kata ga aktif")
                .renderingMode(.template)
                Text("Eksplorasi")
            }).tag(2)
            //tab bar kuis untuk sementara
//            KuisView().tabItem({
//                Image(systemName: "star.fill")
//                Text("Kuis")
//            }).tag(3)
        }
        .accentColor(Color(red: 0.79, green: 0.26, blue: 0.00)
)
    }
}

struct contentRoot_Previews: PreviewProvider {
    static var previews: some View {
        contentRoot()
    }
}
