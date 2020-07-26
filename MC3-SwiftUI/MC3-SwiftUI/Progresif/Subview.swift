//
//  Subview.swift
//  MC3-SwiftUI
//
//  Created by Muhamad Vicky on 24/07/20.
//  Copyright © 2020 Poppy. All rights reserved.
//

import SwiftUI

struct Subview: View {
    var imageString: String
    
    var body: some View {
        Image(imageString)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .clipped()
    }
}

struct Subview_Previews: PreviewProvider {
    static var previews: some View {
        Subview(imageString: "tambah-daftarkelas")
    }
}
