//
//  SwiftUIView.swift
//  MC3-SwiftUI
//
//  Created by Reyhan Rifqi on 18/07/20.
//  Copyright © 2020 Poppy. All rights reserved.
//

import SwiftUI

struct Alphabets {
    let huruf: String
}

struct FonikView: View {
    
    let arrayHuruf: [Alphabets] = [.init(huruf: "A"),
    .init(huruf: "B"),
    .init(huruf: "C"),
    .init(huruf: "D"),
    .init(huruf: "E"),
    .init(huruf: "F"),
    .init(huruf: "G"),]
    
    @State private var title = "bbbbbb"

    var body: some View {
        HStack{
            ScrollView {
                ForEach(self.arrayHuruf, id:  \.huruf){ alfabet in
                    Button(action: {
                        self.title = "\(alfabet.huruf)"
                        
                        }) {
                            AlfabetContainerView(huruf: "\(alfabet.huruf)")

                    }
                
                }
            .padding()

            }
                .frame(width: 80, height: 400, alignment: .center)
                .border(Color.yellow, width: 5)
                .cornerRadius(10)
            Text(title)
        }
    
    }
}

struct FonikView_Previews: PreviewProvider {
    static var previews: some View {
        FonikView()
    }
}
