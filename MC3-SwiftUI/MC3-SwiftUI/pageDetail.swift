//
//  pageDetail.swift
//  MC3-SwiftUI
//
//  Created by Reyhan Rifqi on 17/07/20.
//  Copyright © 2020 Poppy. All rights reserved.
//

import SwiftUI

struct pageDetail: View {
    var sekolah: Sekolah
    var body: some View {
        Text("\(sekolah.namaSekolah)")
    }
}

struct pageDetail_Previews: PreviewProvider {
    static var previews: some View {
        pageDetail(sekolah: Sekolah())
    }
}
