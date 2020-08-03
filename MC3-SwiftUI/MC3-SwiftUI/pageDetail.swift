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

    var sekolah: Sekolah
    var fetchRequest: FetchRequest<Kelas>
    
    
    init(filter: String, sekolah: Sekolah){
        fetchRequest = FetchRequest<Kelas>(entity: Kelas.entity(), sortDescriptors: [], predicate: NSPredicate(format: "idSekolah = %@", filter))
        self.sekolah = sekolah
        
    }
    func appendData() {
        data.removeAll()
        for kelas in fetchRequest.wrappedValue {
            data.append(Type(namaKelas: kelas.namaKelas, gambarKelas: "1", idKelas: kelas.idKelas))
           }
    }
    
    var body: some View {
        VStack{
            HStack(spacing: 0){
                SearchBar(text: $searchText)
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
//                Text(data.idKelas.uuidString)
                Text(data.namaKelas)
                    .bold()
                    .foregroundColor(.black)
                    .frame(width: (UIScreen.main.bounds.width - 70) / 3)
                    .padding(.vertical,10)
                    .padding(.top, 10)
                    .accessibility(label: Text(data.namaKelas))
                
                
                Image(data.gambarKelas)
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: (UIScreen.main.bounds.width - 200) / 3)
                    .cornerRadius(12)
                    .padding(.bottom, 10)
                
            }
            
        }.background(Color.white)
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

                                Spacer(minLength: 10)
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
    @State var data : [Type] = []
//    var fetchRequest: FetchRequest<Kelas>
   
    var sekolah: Sekolah
    var halamanDetail : pageDetail
    
    init(sekolah: Sekolah, pageDetil: pageDetail){

        self.sekolah = sekolah
        self.halamanDetail = pageDetil
    }
    
    
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
                        let kelas = Kelas(context: self.moc)
                        kelas.idKelas = UUID()
                        kelas.namaKelas = self.newKelas
                        kelas.idSekolah = self.sekolah.idSekolah
//                        self.halamanDetail.generateGrid()
                        
                        
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
//                    self.generateGrid()

                    
                    
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
    
//    func appendDataa() {
//        for kelas in fetchRequest.wrappedValue{
//            data.append(Type(namaKelas: kelas.namaKelas, gambarKelas: "1", idKelas: kelas.idKelas))
//        }
//    }
}


//struct pageDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        pageDetail(sekolah: Sekolah())
//    }
//}
