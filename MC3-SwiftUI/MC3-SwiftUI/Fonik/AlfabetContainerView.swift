//
//  AlfabetContainerView.swift
//  MC3-SwiftUI
//
//  Created by Reyhan Rifqi on 18/07/20.
//  Copyright © 2020 Poppy. All rights reserved.
//

import SwiftUI

struct AlfabetContainerView: View {
    var huruf: String

    
    var body: some View {
        ZStack{
            Rectangle()
            .cornerRadius(10)
                .frame(width: 50, height: 50)
                .foregroundColor(.gray)
            Text("\(huruf)")
                .foregroundColor(.primary)
                .font(.system(size: 30, weight: .medium, design: .default))
        }
        
    }
}

struct AlfabetContainerView_Previews: PreviewProvider {
    static var previews: some View {
        AlfabetContainerView(huruf: "A")
    }
}
