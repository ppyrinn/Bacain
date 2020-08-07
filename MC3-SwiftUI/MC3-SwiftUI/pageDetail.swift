//
//  pageDetail.swift
//  MC3-SwiftUI
//
//  Created by Reyhan Rifqi on 17/07/20.
//  Copyright © 2020 Poppy. All rights reserved.
//

import SwiftUI


struct pageDetail: View {
        
    @Environment(\.managedObjectContext) var moc
    
    @State var showingDetail = false
    @State private var searchText = ""
    @State var data : [Type] = []
    @State var Grid : [Int] = []
    @State var namaKelasFilter: String = ""
    @State private var isEditing = false
    
    var fetchRequest: FetchRequest<Kelas>
    var sekolah: Sekolah
    
    init(filter: String, sekolah: Sekolah){
        fetchRequest = FetchRequest<Kelas>(entity: Kelas.entity(), sortDescriptors: [], predicate: NSPredicate(format: "idSekolah = %@", filter))
        self.sekolah = sekolah
    }
    
    func appendData() {
        data.removeAll()
//        let randomInt = String(Int.random(in: 1...10))
        for kelas in fetchRequest.wrappedValue {
            data.append(Type(namaKelas: kelas.namaKelas, gambarKelas: kelas.gambarKelas, idKelas: kelas.idKelas))
        }
    }
    
    var body: some View {
        VStack{
            HStack {
                
                TextField("Search ...", text: $namaKelasFilter)
                    .padding(7)
                    .padding(.horizontal, 25)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .overlay(
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 8)
                            
                            if isEditing {
                                Button(action: {
                                    self.namaKelasFilter = ""
                                }) {
                                    Image(systemName: "multiply.circle.fill")
                                        .foregroundColor(.gray)
                                        .padding(.trailing, 8)
                                }
                            }
                        }
                )
                    .padding(.horizontal, 10)
                    .onTapGesture {
                        self.isEditing = true
                }
                
                if isEditing {
                    Button(action: {
                        self.isEditing = false
                        self.namaKelasFilter = ""
                        self.appendData()
                    })
                    {
                        Text("Cancel")
                    }
                    .padding(.trailing, 10)
                    .transition(.move(edge: .trailing))
                    .animation(.default)
                    
                }
                
            }.padding(.bottom, 10)
            
            HStack{
                FilteredClass(filter: namaKelasFilter, pageDetail: self)
            }
            if data.count == 0 {
                Color(red: 1.00, green: 0.81, blue: 0.42)
                    .padding(.bottom, -50)
            }
            
            VStack(spacing: 0){
                MainView(data: self.$data, Grid: self.$Grid)
            }
            .background(Color.black.opacity(0.06).edgesIgnoringSafeArea(.top))
            .edgesIgnoringSafeArea(.bottom)
            .onAppear {
                self.appendData()
                self.generateGrid()
            }
        }
        .navigationBarTitle("Daftar Kelas").accessibility(label: Text("Daftar Kelas"))
        .navigationBarItems(trailing:
            Button(action: {
                self.showingDetail.toggle()
            }) {
                Image(systemName: "plus")
                    .foregroundColor(.orange)
                    .imageScale(.large)
            }.accessibility(label: Text("Tambah Kelas"))
            .sheet(isPresented: $showingDetail) {
                addClass(sekolah: self.sekolah, pageDetil: self)
                    .environment(\.managedObjectContext, self.moc)
            }
        )
        
        
    }
    
    func generateGrid(){
        Grid.removeAll()
        for i in stride(from: 0, to: self.data.count, by: 2){
            
            if i != self.data.count{
                
                self.Grid.append(i)
            }
            
        }
    }
    
}

struct Card : View {
    
    var data : Type
    @State var showingDetail = false
    
    var body: some View{
            
            
        NavigationLink(destination: DetailStudent(data : data)){
            
            VStack{
                HStack{
                    Text(data.namaKelas)
                    .bold()
                    .foregroundColor(.black)
                    .frame(width: (UIScreen.main.bounds.width - 70) / 3)
                    .padding(.vertical,10)
                    .padding(.top, 10)
                    .accessibility(label: Text(data.namaKelas))
                    
                }.onTapGesture(count: 2) {
                    print("Double tapped!")
                }
                
                Image(data.gambarKelas)
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: (UIScreen.main.bounds.width - 200) / 3)
                    .cornerRadius(12)
                    .padding(.bottom, 10)
                
            }
//            .padding(.trailing, 10)
            
        }
        .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 6)
        
    }
}

struct MainView : View {
    
    @Binding var data : [Type]
    @Binding var Grid : [Int]
    var body: some View{
        VStack{
            if !self.Grid.isEmpty {
                ScrollView(.vertical, showsIndicators: false){
                    
                    ForEach(self.Grid,id: \.self){i in
                        
                        HStack(spacing: 15){
                            
                            ForEach(i...i+1,id: \.self){j in
                                
                                VStack{
                                    if j != self.data.count {
                                        Card(data: self.data[j])
                                    }
                                }
                            }
                            
                            if i == self.Grid.last! && self.data.count % 2 != 0{
                                Spacer()
                            }
                        }
                    }
                }
                .padding()
                .background(Color(red: 1.00, green: 0.81, blue: 0.42))
            }
            
          
        }
        
    }
    
}

struct Type {
    
    var namaKelas : String
    var gambarKelas : String
    var idKelas : UUID
}

struct addClass: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @State var data : [Type] = []

   
    var sekolah: Sekolah
    var halamanDetail : pageDetail
    
    init(sekolah: Sekolah, pageDetil: pageDetail){

        self.sekolah = sekolah
        self.halamanDetail = pageDetil
    }
    
    
    @State private var newKelas = ""
    @State var showDetail = false
    
    var body: some View {
        ZStack{
            VStack{
                HStack {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Batal")
                            .foregroundColor(.orange)
                    }
                    Spacer()
                    
                    Button(action: {
                        let randomInt = String(Int.random(in: 1...10))
                        let kelas = Kelas(context: self.moc)
                        kelas.idKelas = UUID()
                        kelas.namaKelas = self.newKelas
                        kelas.idSekolah = self.sekolah.idSekolah
                        kelas.gambarKelas = randomInt
                        
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



//struct pageDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        pageDetail(sekolah: Sekolah())
//    }
//}
