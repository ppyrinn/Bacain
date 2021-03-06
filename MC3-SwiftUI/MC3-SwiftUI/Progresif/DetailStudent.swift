//
//  DetailStudent.swift
//  MC3-SwiftUI
//
//  Created by Muhamad Vicky on 29/07/20.
//  Copyright © 2020 Poppy. All rights reserved.
//

import SwiftUI

struct DetailStudent: View {

    @Environment(\.managedObjectContext) var moc

    @State var showingDetail = false
    @State private var searchText = ""
    @State var data : [TypeMurid] = []
    @State var Grid : [Int] = []
    @State var namaMuridFilter: String = ""
    @State private var isEditing = false
    
    var idKelas : UUID

    var kelas: Type
    var fetchRequest: FetchRequest<Murid>
    
    
    init(data: Type){
        self.idKelas = data.idKelas
        fetchRequest = FetchRequest<Murid>(entity: Murid.entity(), sortDescriptors: [], predicate: NSPredicate(format: "idKelas = %@", data.idKelas.uuidString))
        self.kelas = data
    }
    
    func appendData() {
        var listMurid: [Murid] = []
        do{
            listMurid = try moc.fetch(Murid.getMuridWithId(id: self.kelas.idKelas))
        }catch{
            print(error)
        }
        data.removeAll()
        
        for murid in listMurid {
            data.append(TypeMurid(idMurid: murid.idMurid, namaMurid: murid.namaMurid, progress: murid.progress))
        }


    }
    

    var body: some View {
        VStack{
            HStack {
                
                TextField("Cari...", text: $namaMuridFilter)
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
                                    self.namaMuridFilter = ""
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
                        self.namaMuridFilter = ""
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
//                SearchBar(text: $searchText)
                FilteredStudent(filter: namaMuridFilter, detailMurid: self)
            }
            if data.count == 0 {
                VStack{
                    Color(red: 1.00, green: 0.81, blue: 0.42)
                        .padding(.bottom, -20)
                    Image("tambah-daftarmurid")
                        .padding(.top, -550)
                    Text("Kamu belum memiliki murid. Tambah murid terlebih dahulu")
                        .bold()
                        .padding(.top, -200)
                }
                    .padding(.bottom, -50)
            }
            
            VStack(spacing: 0){
                Main(data: self.$data, Grid: self.$Grid, DetailStudent: self)
            }
            .background(Color.black.opacity(0.06).edgesIgnoringSafeArea(.top))
            .edgesIgnoringSafeArea(.bottom)
            .onAppear {
                self.appendData()
                self.generateGrid()
            }
            .navigationBarTitle(kelas.namaKelas).accessibility(label: Text(kelas.namaKelas))
            .navigationBarItems(trailing:
                Button(action: {
                    self.showingDetail.toggle()
                }) {
                    Text("Tambah Murid")
                        .foregroundColor(Color(red: 0.79, green: 0.26, blue: 0.0))
                        .imageScale(.large)
                }.accessibility(label: Text("Tambah Murid"))
                    .sheet(isPresented: $showingDetail) {
                        addMurid(kelas: self.kelas, detailStudent: self)
                            .environment(\.managedObjectContext, self.moc)
                }
            )
        }
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

struct CardStudent : View {
    
    var data : TypeMurid
//    @State var showingDetail = false
    @State private var showingAlert = false
    @State var progressValue: Float = Float.random(in: 0...1)
    @Environment(\.managedObjectContext) var moc
    
    var DetailStudent : DetailStudent
    
    var body: some View{
        
        
        NavigationLink(destination: DetailScoring(data : data)){
            
            VStack{

                HStack{
                    Text(data.namaMurid)
                    .bold()
                    .foregroundColor(.black)
                    .frame(width: (UIScreen.main.bounds.width - 70) / 3)
                    .padding(.vertical,10)
                    .padding(.top, 10)
                    .accessibility(label: Text(data.namaMurid))
                }
                .alert(isPresented:$showingAlert) {
                    Alert(title: Text("Apakah kamu yakin ingin menghapus kelas \(data.namaMurid) ?"), message: Text("Data tidak bisa dikembalikan."), primaryButton: .destructive(Text("Hapus")) {
                            print("Menghapus...")
                        self.delete(at: self.data.idMurid)
                    }, secondaryButton: .cancel(Text("Batal")))
                }

                
                
                ProgressBar(value: $progressValue)
                    .frame(height: 20)
                    .padding(15)
                    .padding(.top, -30)
                
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

        var hasilFetch : [Murid] = []
        do {
            hasilFetch = try moc.fetch(Murid.getMuridWithIdMurid(id: offsets))
        } catch {
            print(error)
        }
        
        for kelas in hasilFetch {
            self.moc.delete(kelas)
        }



        do {
            try self.moc.save()
            self.DetailStudent.appendData()
            self.DetailStudent.generateGrid()
        } catch  {
            print("error")
        }

    }
    
}

struct Main : View {

    @Binding var data : [TypeMurid]
    @Binding var Grid : [Int]
    
    @State var isPresented = false
    var DetailStudent : DetailStudent
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var body: some View{
        VStack{
            if !self.Grid.isEmpty {
                ScrollView(.vertical, showsIndicators: false){
                    
                    ForEach(self.Grid,id: \.self){i in
                        
                        HStack(spacing: 15){
                            
                            ForEach(i...i+1,id: \.self){j in
                                
                                VStack{
                                    if j != self.data.count {
                                        
                                        CardStudent(data: self.data[j], DetailStudent : self.DetailStudent)
                                    }
                                }
                            }
                            
                            if i == self.Grid.last! && self.data.count % 2 != 0{
                                
                                Spacer(minLength: 370)
                                
                            }
                        }
                    }
                }
                .padding()
                .background(Color(red: 1.00, green: 0.81, blue: 0.42))
                Button(action: {
                    self.isPresented.toggle()
                }){
                    Image("mulaikuis-button")
                }
                .accessibility(label: Text("Mulai Kuis"))
                .padding(.bottom,80)
                .sheet(isPresented: $isPresented){
                    KuisView(daftarMurid : self.data).environment(\.managedObjectContext, self.context)
                }
            }
            
        }.background(Color(red: 1.00, green: 0.81, blue: 0.42))
        
    }

}

struct TypeMurid {
    
    var idMurid : UUID
    var namaMurid : String
    var progress : Int64
}




struct addMurid: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode

    var kelas : Type
    var detailStudent: DetailStudent
    init(kelas: Type, detailStudent: DetailStudent) {
        self.kelas = kelas
        self.detailStudent = detailStudent
    }

    @State private var newMurid = ""
//    @State var showDetail = false
    @State private var showingAlert = false
    @State var value : CGFloat = 0

    var body: some View {
        ZStack{
            VStack{
                HStack{
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Batal")
                            .foregroundColor(Color(red: 0.79, green: 0.26, blue: 0.0))
                    }
                    Spacer()

                    Button(action: {

                        if self.newMurid == "" {
                            self.showingAlert = true
                        } else {
                            let murid = Murid(context: self.moc)
                            murid.idMurid = UUID()
                            murid.namaMurid = self.newMurid
                            murid.idKelas = self.kelas.idKelas
                            
                            do{
                                try self.moc.save()
                                self.detailStudent.appendData()
                            }catch{
                                print(error)
                            }
                            self.newMurid = ""
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    }) {
                        if newMurid.isEmpty {
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
                    .disabled(newMurid.isEmpty)
                }
                .padding(30)
                Spacer()

                VStack{
                    HStack{
                        Text("Tambah Murid")
                            .font(.title)
                            .bold()
                            .foregroundColor(Color(red: 0.79, green: 0.26, blue: 0.0))
                    }
                    HStack{
                        Text("Tambahkan murid-murid kamu dan pantau perkembangan membaca mereka")
                    }
                    HStack{
                        Text("Murid")
                            .foregroundColor(Color(red: 0.79, green: 0.26, blue: 0.0))
                            .bold()
                        TextField("Nama Murid", text: self.$newMurid)
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
        }.onDisappear{
            self.detailStudent.generateGrid()
        }
    }

}



//struct DetailStudent_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailStudent()
//    }
//}

//Text(kelas.namaKelas)

struct DetailStudent_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
