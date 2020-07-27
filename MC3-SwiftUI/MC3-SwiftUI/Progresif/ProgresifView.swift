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
    @State private var searchText = ""
    
    var body: some View {
       NavigationView {
        
//                contentRoot()
                
        List{
            Section(header: Text("Daftar Sekolah")) {
                ForEach(self.listOfSekolah, id: \.namaSekolah){ item in
                    NavigationLink(destination: pageDetail(sekolah: item)) {
                        Text("\(item.namaSekolah)")
                        
                    }
                    .padding(15)
                    .background(Color(red: 1.00, green: 0.81, blue: 0.42))
                    .cornerRadius(25)
                    
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
                Image(systemName: "plus")
                    .foregroundColor(Color(red: 0.79, green: 0.26, blue: 0.0))
                    .imageScale(.large)
            }.sheet(isPresented: $showingDetail) {
                addSchool()
                    .environment(\.managedObjectContext, self.moc)
            }
            
        )
        
        ZStack{
            VStack{
                Color(red: 1.00, green: 0.81, blue: 0.42)
                    .padding(.bottom, -20)
                Image("tambah-daftarkelas")
                    .padding(.top, -550)
                Text("Kamu Belum Memilih/Memiliki Sekolah. Pilih/Tambah Sekolah Terlebih Dulu")
                    .bold()
                    .padding(.top, -200)
            }
        .navigationBarTitle("Daftar Kelas")
        }
        
        
                
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
                        let sekolah = Sekolah(context: self.moc)
                        sekolah.namaSekolah = self.newSekolah
                        let id = UUID()
                        sekolah.idSekolah = id
                        
                        print("textnya adalah", self.newSekolah)
                        
                        do{
                            try self.moc.save()
                        }catch{
                            print(error)
                        }
                        self.newSekolah = ""
                        
                    }) {
                        Text("Tambah Sekolah")
                            .foregroundColor(Color(red: 0.79, green: 0.26, blue: 0.0))
                    }
                    
                    
                    }
                .padding(30)
                
                Spacer()
                
                HStack{
                    Text("Tambah Sekolah")
                        .font(.largeTitle)
                        .foregroundColor(.orange)
                }
                HStack{
                    Text("Tambah Sekolah yang ingin kamu simpan/track perkembangan murdinya")
                        
                }
                HStack{
                    Text("Sekolah")
                    .foregroundColor(.orange)
                    .bold()
                    TextField("Sekolah Baru", text: self.$newSekolah)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    .onAppear {
                        UITableView.appearance().separatorStyle = .singleLine
                    }
                }
                .padding(30)
                Spacer()
                }
            }
        }
    }

struct addClass: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(fetchRequest: Sekolah.getAllSekolah()) var listOfSekolah: FetchedResults<Sekolah>
    @State private var newKelas = ""
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
                        let sekolah = Sekolah(context: self.moc)
                        sekolah.namaSekolah = self.newKelas
                        let id = UUID()
                        sekolah.idSekolah = id
                        
                        do{
                            try self.moc.save()
                        }catch{
                            print(error)
                        }
                        self.newKelas = ""
                        
                    }) {
                        Text("Tambah Kelas")
                            .foregroundColor(Color(red: 0.79, green: 0.26, blue: 0.0))
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
                    Text("Tambah Kelas yang ingin kamu simpan/track perkembangan murdinya")
                    
                }
                HStack{
                    Text("Kelas")
                        .foregroundColor(.orange)
                        .bold()
                    TextField("Kelas Baru", text: self.$newKelas)
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
