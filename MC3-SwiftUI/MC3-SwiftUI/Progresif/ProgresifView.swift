//
//  ContentView.swift
//  MC3-SwiftUI
//
//  Created by Poppy on 17/07/20.
//  Copyright © 2020 Poppy. All rights reserved.
//

import SwiftUI

struct ProgresifView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(fetchRequest: Sekolah.getAllSekolah()) var listOfSekolah: FetchedResults<Sekolah>
    
    @State private var newSekolah = ""
    
    var body: some View {
       NavigationView {
                List{
                    Section(header: Text("Tambah Sekolah Baru")) {
                        HStack{
                            TextField("Sekolah Baru", text: self.$newSekolah)
                            Button(action: {
                                let sekolah = Sekolah(context: self.moc)
                                sekolah.namaSekolah = self.newSekolah
                                
                                do{
                                    try self.moc.save()
                                }catch{
                                    print(error)
                                }
                                
                                self.newSekolah = ""
                            }) {
                                Image(systemName: "plus.circle.fill")
                                    .foregroundColor(.green)
                                    .imageScale(.large)
                            }
                        }
                        .font(.headline)
                    }
                    Section(header: Text("Daftar Sekolah")) {
                        ForEach(self.listOfSekolah, id: \.namaSekolah){ item in
                            NavigationLink(destination: pageDetail(sekolah: item)) {
                                    Text("\(item.namaSekolah)")

                            }

                        }
                        .onDelete(perform: deleteItem)
                    }
            }
            .navigationBarTitle("Progresif")
            .navigationBarItems(trailing: EditButton())
        }
    }
    
    func deleteItem(indexSet: IndexSet){
        let source = indexSet.first!
        let item = listOfSekolah[source]
        moc.delete(item)
        do{
            try self.moc.save()
        }catch{
            print(error)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ProgresifView()
    }
}
