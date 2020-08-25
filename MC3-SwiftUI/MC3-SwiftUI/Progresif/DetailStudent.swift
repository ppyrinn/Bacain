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

    var kelas: Type
    var fetchRequest: FetchRequest<Murid>
    
    
    init(data: Type){
        fetchRequest = FetchRequest<Murid>(entity: Murid.entity(), sortDescriptors: [], predicate: NSPredicate(format: "idKelas = %@", data.idKelas.uuidString))
        self.kelas = data
    }
    
    func appendData() {
        data.removeAll()
        for murid in fetchRequest.wrappedValue {
            data.append(TypeMurid(idMurid: murid.idMurid, namaMurid: murid.namaMurid, progress: murid.progress))
           }
    }
    

    var body: some View {
        VStack{
<<<<<<< HEAD

=======
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
            
>>>>>>> 210887e... Merge pull request #22 from ppyrinn/KuisAndDetailMurid
            HStack{
                SearchBar(text: $searchText)
            }
            if data.count == 0 {
<<<<<<< HEAD
                Color(red: 1.00, green: 0.81, blue: 0.42)
=======
                VStack{
                    Color(red: 1.00, green: 0.81, blue: 0.42)
                        .padding(.bottom, -20)
                    Image("tambah-daftarmurid")
                        .padding(.top, -550)
                    Text("Kamu belum memiliki murid. Tambah murid terlebih dahulu")
                        .bold()
                        .padding(.top, -200)
                }
>>>>>>> 210887e... Merge pull request #22 from ppyrinn/KuisAndDetailMurid
                    .padding(.bottom, -50)
            }
            
            VStack(spacing: 0){
                Main(data: self.$data, Grid: self.$Grid)
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
                    Image(systemName: "plus")
                        .foregroundColor(.orange)
                        .imageScale(.large)
                }.accessibility(label: Text("Tambah Murid"))
                    .sheet(isPresented: $showingDetail) {
                        addMurid(kelas: self.kelas)
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
    @State var showingDetail = false
    @State var progressValue: Float = 0.2
    
    var body: some View{
        
        
        NavigationLink(destination: DetailScoring()){
            
            VStack{
//                , alignment: .topLeading
                Text(data.namaMurid)
                    .bold()
                    .foregroundColor(.black)
                    .frame(width: (UIScreen.main.bounds.width - 70) / 4)
                    .padding(.vertical,10)
                    .padding(.top, 10)
                    .accessibility(label: Text(data.namaMurid))
<<<<<<< HEAD
=======
                }
                .alert(isPresented:$showingAlert) {
                    Alert(title: Text("Apakah kamu yakin ingin menghapus kelas \(data.namaMurid) ?"), message: Text("Data tidak bisa dikembalikan."), primaryButton: .destructive(Text("Hapus")) {
                            print("Menghapus...")
                        self.delete(at: self.data.idMurid)
                    }, secondaryButton: .cancel(Text("Batal")))
                }

>>>>>>> 210887e... Merge pull request #22 from ppyrinn/KuisAndDetailMurid
                
                
                ProgressBar(value: $progressValue).frame(height: 20)
                .padding(15)
                .padding(.top, -30)
    
            }
   
        }.background(Color.white)
        .cornerRadius(10)
            .shadow(radius: 6)
        
    }
}

struct Main : View {

    @Binding var data : [TypeMurid]
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

                                        CardStudent(data: self.data[j])
                                    }
                                }
                            }

                            if i == self.Grid.last! && self.data.count % 2 != 0{

                                Spacer(minLength: 370)
//                                    .padding(.leading, 20)
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

struct TypeMurid {
    
    var idMurid : UUID
    var namaMurid : String
    var progress : Int64
}




struct addMurid: View {
    @Environment(\.managedObjectContext) var moc

    var kelas : Type
    init(kelas: Type) {
        self.kelas = kelas
    }

    @State private var newMurid = ""
    @State var showDetail = true

    var body: some View {
        ZStack{
            VStack{
                HStack{
                    Button(action: {
                        self.showDetail.toggle()
                    }) {
                        Text("Batal")
                            .foregroundColor(Color(red: 0.79, green: 0.26, blue: 0.0))
                    }
                    Spacer()

                    Button(action: {
                        let murid = Murid(context: self.moc)
                        murid.idMurid = UUID()
                        murid.namaMurid = self.newMurid
                        murid.idKelas = self.kelas.idKelas
                        
                        do{
                            try self.moc.save()
                        }catch{
                            print(error)
                        }
                        self.newMurid = ""
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
<<<<<<< HEAD
=======
                    .disabled(newMurid.isEmpty)
>>>>>>> 210887e... Merge pull request #22 from ppyrinn/KuisAndDetailMurid
                }
                .padding(30)
                Spacer()

<<<<<<< HEAD
                HStack{
                    Text("Tambah Murid")
                        .font(.largeTitle)
                        .foregroundColor(.orange)
=======
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
>>>>>>> 210887e... Merge pull request #22 from ppyrinn/KuisAndDetailMurid
                }
                HStack{
                    Text("Tambahkan murid-murid kamu dan track perkembangan membaca mereka")
                }
                HStack{
                    Text("Murid")
                        .foregroundColor(.orange)
                        .bold()
                    TextField("Nama Murid", text: self.$newMurid)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding(30)
                Spacer()
            }
        }
    }

}



//struct DetailStudent_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailStudent()
//    }
//}

//Text(kelas.namaKelas)
