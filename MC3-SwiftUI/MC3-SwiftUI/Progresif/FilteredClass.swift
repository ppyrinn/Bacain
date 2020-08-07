//
//  FilteredClass.swift
//  MC3-SwiftUI
//
//  Created by Muhamad Vicky on 06/08/20.
//  Copyright © 2020 Poppy. All rights reserved.
//

import SwiftUI

struct FilteredClass: View {
    @State var data: [Type] = []
    var fetchRequest: FetchRequest<Kelas>
    var kelas: FetchedResults<Kelas> {fetchRequest.wrappedValue}
    var pageDetail : pageDetail
    
    var body: some View {
        VStack{
            ForEach(fetchRequest.wrappedValue, id: \.self){ kelas in
                Text("")
            }
            .onAppear{
                self.appendData()
                self.pageDetail.generateGrid()
            }
        }
    }
    
    init(filter: String, pageDetail: pageDetail){
        fetchRequest = FetchRequest<Kelas>(entity: Kelas.entity(), sortDescriptors: [], predicate: NSPredicate(format: "namaKelas BEGINSWITH %@", filter))
        self.pageDetail = pageDetail
    }
    
    func appendData() {
        self.pageDetail.data.removeAll()
        for kelas in fetchRequest.wrappedValue {
            self.pageDetail.data.append(Type(namaKelas: kelas.wrappedNamaKelas, gambarKelas: kelas.wrappedGambarKelas, idKelas: kelas.wrappedIdKelas))
        }
    }
}


