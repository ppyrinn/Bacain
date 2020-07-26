//
//  DaftarKelas.swift
//  MC3-SwiftUI
//
//  Created by Muhamad Vicky on 23/07/20.
//  Copyright © 2020 Poppy. All rights reserved.
//

import SwiftUI

//struct DataModel: Identifiable {
//    let id: String
//    let name: String
//    let imageName: String
//}


struct DaftarKelas: View {
    
    
    let data: [DataModel] = [
    .init(id: "0", name: "SteveJobs", imageName: "SteveJobs"),
    .init(id: "1", name: "Satya Nadella", imageName: "Satya Nadella"),
    .init(id: "2", name: "Jeff Bezos", imageName: "Jeff Bezos"),
    .init(id: "3", name: "Tim Cook", imageName: "Tim Cook")
    ]
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(data) { items in
                    ForEach(0..<2) { item in
                        CollectionView(data: items)
                    }
                }
            }.navigationBarTitle("CollectionView")
        }
    }
}

//struct CollectionView: View {
//    let data: DataModel
//    var body: some View {
//        VStack {
//            HStack {
//                ForEach(0..<2) { items in
//                    Spacer()
//                    Image(self.data.imageName)
//                        .resizable()
//                        .frame(width: 150, height: 150)
//                        .foregroundColor(.yellow)
//                        .clipShape(Circle())
//                        .shadow(radius: 10)
//                    Spacer()
//                }.padding(.bottom, 16)
//            }
//            HStack {
//                Spacer()
//                Text(self.data.name)
//                Spacer()
//                Text(self.data.name)
//                Spacer()
//            }
//        }
//    }
//}



struct DaftarKelas_Previews: PreviewProvider {
    static var previews: some View {
        DaftarKelas()
    }
}
