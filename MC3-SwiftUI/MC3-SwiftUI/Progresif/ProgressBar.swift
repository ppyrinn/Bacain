//
//  ProgressBar.swift
//  MC3-SwiftUI
//
//  Created by Muhamad Vicky on 02/08/20.
//  Copyright © 2020 Poppy. All rights reserved.
//

import SwiftUI

struct ProgressBar: View {
    @Binding var value: Float
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading){
                Rectangle().frame(width: geometry.size.width, height: geometry.size.height)
                    .foregroundColor(Color.white)
                    .border(Color.orange, width: 2)
                
                Rectangle().frame(width: min(CGFloat(self.value)*geometry.size.width, geometry.size.width))
                    .foregroundColor(Color.init(red: 0.79, green: 0.26, blue: 0.0))
                    .animation(.linear)
            }.cornerRadius(15.0)
        }
        
    }
}

//struct ProgressBar_Previews: PreviewProvider {
//    static var previews: some View {
//        ProgressBar()
//    }
//}
