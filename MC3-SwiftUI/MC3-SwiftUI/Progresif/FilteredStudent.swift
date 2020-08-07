//
//  FilteredStudent.swift
//  MC3-SwiftUI
//
//  Created by Muhamad Vicky on 05/08/20.
//  Copyright © 2020 Poppy. All rights reserved.
//

import SwiftUI

struct FilteredStudent: View {
    @State var data : [TypeMurid] = []
    var fetchRequest: FetchRequest<Murid>
    var murid: FetchedResults<Murid> {
        fetchRequest.wrappedValue
    }
    var detailMurid : DetailStudent
    
    var body: some View {
        VStack{

            
            ForEach(fetchRequest.wrappedValue, id: \.self) { murid in
                //            MainView(data: self.$data, Grid: self.$Grid)
                Text("")
            }
            .onAppear{
            self.appendData()
            self.detailMurid.generateGrid()
            
//            MainView(data: self.$data, Grid: self.$Grid)
        
        }
        }
        
        
    }
    
    init(filter: String, detailMurid: DetailStudent) {
        fetchRequest = FetchRequest<Murid>(entity: Murid.entity(), sortDescriptors: [], predicate: NSPredicate(format: "namaMurid BEGINSWITH %@", filter))
        self.detailMurid = detailMurid
    }
    
    func appendData(){
        self.detailMurid.data.removeAll()
        for murid in fetchRequest.wrappedValue {
            self.detailMurid.data.append(TypeMurid(idMurid: murid.wrappedIdMurid, namaMurid: murid.wrappedNamaMurid, progress: murid.wrappedProgress))

        }

    }
    
//    func generateGrid(){
//        Grid.removeAll()
//        for i in stride(from: 0, to: self.data.count, by: 2){
//            if i != self.data.count {
//                self.Grid.append(i)
//            }
//        }
//    }
    

}


