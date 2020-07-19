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

    @Environment(\.managedObjectContext) var moc
    @FetchRequest(fetchRequest: Kelas.getAllKelas()) var listOfKelas: FetchedResults<Kelas>

    var body: some View {
        HStack{
            VStack{
                
                Text("\(self.sekolah.idSekolah)")

                Text("\(sekolah.namaSekolah)")
                

            }
            List{
                ForEach(self.listOfKelas, id: \.idKelas){ item in
                        Text("\(item.namaKelas)")
                }
            }
        }
    }
    
    func getKelas(){
        
    }
}

struct pageDetail_Previews: PreviewProvider {
    static var previews: some View {
        pageDetail(sekolah: Sekolah())
    }
}
