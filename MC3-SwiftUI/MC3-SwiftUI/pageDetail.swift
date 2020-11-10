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
    var listKelas: FetchedResults<Kelas> {fetchRequest.wrappedValue}
    var sekolah: Sekolah

    
    init(filter: String, sekolah: Sekolah){
        fetchRequest = FetchRequest<Kelas>(entity: Kelas.entity(), sortDescriptors: [], predicate: NSPredicate(format: "idSekolah = %@", filter))
        self.sekolah = sekolah
    }
    
    func appendData() {
        
        var listKelas: [Kelas] = []
        do{
            listKelas = try moc.fetch(Kelas.getKelasWithId(id: self.sekolah.idSekolah))
        }catch{
            print(error)
        }
        
        data.removeAll()
        for kelas in listKelas {
            data.append(Type(namaKelas: kelas.namaKelas, gambarKelas: kelas.gambarKelas, idKelas: kelas.idKelas))
        }
        print(data)
    }
    
//    func appendDataSearch () {
//        data.removeAll()
//        for kelas in fetchRequest.wrappedValue {
//            data.append(Type(namaKelas: kelas.namaKelas, gambarKelas: kelas.gambarKelas, idKelas: kelas.idKelas))
//        }
//        print(data)
//    }
    
    var body: some View {
        VStack{
            HStack {
                
                TextField("Search ...", text: $namaKelasFilter)
                    .keyboardType(.webSearch)
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
                VStack{
                    Color(red: 1.00, green: 0.81, blue: 0.42)
                        .padding(.bottom, -20)
                    Image("tambah-daftarkelas")
                        .padding(.top, -550)
                    Text("Kamu Belum Memiliki Kelas. Tambah Kelas Terlebih Dulu")
                        .bold()
                        .padding(.top, -200)
                }
                    .padding(.bottom, -50)
            }
            
            VStack(spacing: 0){
                MainView(data: self.$data, Grid: self.$Grid, pageDetail: self)
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
                Text("Tambah Kelas")
                    .foregroundColor(Color(red: 0.79, green: 0.26, blue: 0.0))
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
    
    var dataa : Type
    @State var showingDetail = false
    @State private var showingAlert = false
    @Environment(\.managedObjectContext) var moc
    
    var pageDetail : pageDetail
    
    
    
    var body: some View{
        
            
        NavigationLink(destination: DetailStudent(data : dataa)){
            VStack{
                
                HStack{
                    Text(dataa.namaKelas)
                    .bold()
                    .foregroundColor(.black)
                    .frame(width: (UIScreen.main.bounds.width - 70) / 3)
                    .padding(.vertical,10)
                    .padding(.top, 10)
                    .accessibility(label: Text(dataa.namaKelas))
                }
//                .onLongPressGesture(minimumDuration: 1) {
//                    self.showingAlert = true
//
//                }
                .alert(isPresented:$showingAlert) {
                    Alert(title: Text("Apakah Kamu Yakin Ingin Menghapus Kelas \(dataa.namaKelas) ?"), message: Text("Data tidak bisa dikembalikan"), primaryButton: .destructive(Text("Hapus")) {
                            print("Menghapus...")
                        self.delete(at: self.dataa.idKelas)
                    }, secondaryButton: .cancel(Text("Batal")))
                }
                
                
                Image(dataa.gambarKelas)
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: (UIScreen.main.bounds.width - 200) / 3)
                    .cornerRadius(12)
                    .padding(.bottom, 10)
                
                

            }
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 6)
        .contextMenu{
            VStack{
                Button(action: {
                    self.showingAlert.toggle()
                }){
                    Text("Hapus")
                }
                Text("Batal")
            }
        }
    }
    
    func delete(at offsets: UUID){

        var hasilFetch : [Kelas] = []
        do {
            hasilFetch = try moc.fetch(Kelas.getKelasWithIdKelas(id: offsets))
        } catch {
            print(error)
        }
        
        for kelas in hasilFetch {
            self.moc.delete(kelas)
        }



        do {
            try self.moc.save()
            self.pageDetail.appendData()
            self.pageDetail.generateGrid()
        } catch  {
            print("error")
        }

    }
    
    
}

struct MainView : View {
    
    @Binding var data : [Type]
    @Binding var Grid : [Int]
    var pageDetail : pageDetail
    var body: some View{
        VStack{
            if !self.Grid.isEmpty {
                ScrollView(.vertical, showsIndicators: false){
                    
                    ForEach(self.Grid,id: \.self){i in
                        
                        HStack(spacing: 15){
                            
                            ForEach(i...i+1,id: \.self){j in
                                
                                VStack{
                                    if j != self.data.count {
                                        Card(dataa: self.data[j], pageDetail: self.pageDetail)
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
    @State var value : CGFloat = 0
    @State private var newKelas = ""
    @State var showDetail = false
    
    var sekolah: Sekolah
    var halamanDetail : pageDetail
    
    init(sekolah: Sekolah, pageDetil: pageDetail){
        self.sekolah = sekolah
        self.halamanDetail = pageDetil
    }
    
    var body: some View {
        ZStack{
            VStack{
                HStack {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Batal")
                            .bold()
                            .foregroundColor(Color(red: 0.79, green: 0.26, blue: 0.0))
                    }.accessibility(label: Text("Batal"))
                    Spacer()
                    
                    Button(action: {

                        if self.newKelas == "" {
                            self.showDetail = true
                        } else {
                            let randomInt = String(Int.random(in: 1...10))
                            let kelas = Kelas(context: self.moc)
                            kelas.idKelas = UUID()
                            kelas.namaKelas = self.newKelas
                            kelas.idSekolah = self.sekolah.idSekolah
                            kelas.gambarKelas = randomInt
                            
                            do{
                                try self.moc.save()
                                self.halamanDetail.appendData()
                            }catch{
                                print(error)
                            }
                            self.newKelas = ""
                            self.presentationMode.wrappedValue.dismiss()

                        }
                        
                        
                    }) {
                        if newKelas.isEmpty {
                            Text("Simpan")
                            .bold()
                            .accessibility(label: Text("Simpan"))
                            .foregroundColor(Color.gray)
                        } else {
                            Text("Simpan")
                            .bold()
                            .accessibility(label: Text("Simpan"))
                            .foregroundColor(Color(red: 0.79, green: 0.26, blue: 0.0))
                        }
                    }
                    .disabled(newKelas.isEmpty)
                }
                .padding(30)
                
                Spacer()
                
                VStack{
                    HStack{
                        Text("Tambah Kelas")
                            .font(.title)
                            .bold()
                            .foregroundColor(Color(red: 0.79, green: 0.26, blue: 0.0))
                    }
                    HStack{
                        Text("Tambah Kelas yang ingin kamu simpan/track perkembangan murdinya")
                    }
                    HStack{
                        Text("Kelas")
                            .foregroundColor(Color(red: 0.79, green: 0.26, blue: 0.0))
                            .bold()
                        TextField("Nama Kelas", text: self.$newKelas)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    .padding(30)
                    .padding(.top, -20)
                    
                }
                .offset(y: -self.value)
                .animation(.spring())
                .onAppear{
                    NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { (noti) in
                        let value = noti.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
                        let height = value.height - 250
                        
                        self.value = height
                        
                    }
                    
                    NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { (noti) in
                        
                        self.value = 0
                    }
                }
                
                Spacer()
            }
            
            
        }
        .onDisappear{
            self.halamanDetail.generateGrid()
        }
    }

}


//struct pageDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        pageDetail(sekolah: Sekolah())
//    }
//}
