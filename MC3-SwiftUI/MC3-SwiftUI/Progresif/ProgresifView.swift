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
    @State var showingDetail = false
    
    var body: some View {
       NavigationView {
        
//                contentRoot()
                
                List{
//                    Section(header: Text("Tambah Sekolah Baru")) {
//                        HStack{
//                            TextField("Sekolah Baru", text: self.$newSekolah)
//                            Button(action: {
//                                let sekolah = Sekolah(context: self.moc)
//                                sekolah.namaSekolah = self.newSekolah
//
//                                do{
//                                    try self.moc.save()
//                                }catch{
//                                    print(error)
//                                }
//
//                                self.newSekolah = ""
//                            }) {
//                                Image(systemName: "plus.circle.fill")
//                                    .foregroundColor(.green)
//                                    .imageScale(.large)
//                            }
//                        }
//                        .font(.headline)
//                    }
                    
                    Section(header: Text("Daftar Sekolah")) {
                        ForEach(self.listOfSekolah, id: \.namaSekolah){ item in
                            NavigationLink(destination: pageDetail(sekolah: item)) {
                                    Text("\(item.namaSekolah)")

                            }
                            .padding(15)
                            .background(Color.orange)
                            .cornerRadius(15)

                        }
                        .onDelete(perform: deleteItem)
                    }
            }
            .onAppear {
                UITableView.appearance().separatorStyle = .none
            }
                    
            .navigationBarTitle("Progresif")
            .navigationBarItems(trailing:
                Button(action: {
                    self.showingDetail.toggle()
                }) {
                    Image(systemName: "plus.circle.fill")
                    .foregroundColor(.orange)
                    .imageScale(.large)
                }.sheet(isPresented: $showingDetail) {
                    addSchool()
                }
                
            )
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

struct addSchool: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(fetchRequest: Sekolah.getAllSekolah()) var listOfSekolah: FetchedResults<Sekolah>
    @State private var newSekolah = ""
    @State var showDetail = true
    
    var body: some View {
        ZStack{
            VStack{
                HStack {
                    
                    Button(action: {
                        self.showDetail.toggle()
                        
                    }) {
                        Text("Batal")
                            .foregroundColor(.orange)
                    }
                    
                    
                    Spacer()
                    
                    Button(action: {
                        // show new task view
                        let sekolah = Sekolah(context: self.moc)
                        sekolah.namaSekolah = self.newSekolah
                        
                        do{
                            try self.moc.save()
                        }catch{
                            print(error)
                        }
                        
                        self.newSekolah = ""
                        
                    }) {
                        Text("Tambah Kelas")
                            .foregroundColor(.orange)
                    }
                    
                    
                    }
                .padding(30)
                
                Spacer()
                
                HStack{
                    Text("Tambah Kelas")
                        .font(.largeTitle)
                        .foregroundColor(.orange)
                }
                
                HStack{
                    Text("Tambah Kelas yang ingin kamu simpan perkembangan murdinya")
                        
                }
                
                HStack{
                    Text("Kelas")
                        .foregroundColor(.orange)
                        .bold()
                    TextField("Sekolah Baru", text: self.$newSekolah)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding(30)
                Spacer()
                
                    
                }
            }
        }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ProgresifView()
    }
}
