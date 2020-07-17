//
//  ContentView.swift
//  MC3-SwiftUI
//
//  Created by Poppy on 17/07/20.
//  Copyright © 2020 Poppy. All rights reserved.
//

import SwiftUI

struct ProgresifView: View {
    var sekolah = ["SD Maju","SD Mundur", "SD Maju Mundur"]
    var body: some View {
       NavigationView {
            NavigationLink(destination: Text("New secondary")) {
                List(0..<sekolah.count){ item in
                    VStack(alignment: .leading){
                        Text(self.sekolah[item])
                    }
                }
                
            }
            .navigationBarTitle("Progresif")

            Text("Secondary")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ProgresifView()
    }
}
