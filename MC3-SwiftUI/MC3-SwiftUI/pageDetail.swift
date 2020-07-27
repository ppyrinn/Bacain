//
//  pageDetail.swift
//  MC3-SwiftUI
//
//  Created by Reyhan Rifqi on 17/07/20.
//  Copyright © 2020 Poppy. All rights reserved.
//

import SwiftUI


struct pageDetail: View {
    var sekolah: Sekolah
    
    @Environment(\.managedObjectContext) var moc
//    @FetchRequest(fetchRequest: Kelas.getKelasWithId(id: sekolah.idSekolah)) var listOfKelas: FetchedResults<Kelas>
    
    var fetchRequest: FetchRequest<Kelas>
    
    @State var showingDetail = false
    @State private var searchText = ""
    
    @State var data = [
        
        Type(namaKelas: "Kelas 1", gambarKelas: "1"),
        Type(namaKelas: "Kelas 2", gambarKelas: "2"),
        Type(namaKelas: "Kelas 3", gambarKelas: "3"),
        Type(namaKelas: "Kelas 4", gambarKelas: "4"),
        Type(namaKelas: "Kelas 5", gambarKelas: "5"),
//        Type(namaKelas: "Kelas 6", gambarKelas: "6"),

    ]
    
    @State var Grid : [Int] = []
    
    init(filter: String, sekolah: Sekolah){
        fetchRequest = FetchRequest<Kelas>(entity: Kelas.entity(), sortDescriptors: [], predicate: NSPredicate(format: "idSekolah = %@", filter))
        self.sekolah = sekolah
    }
    
    
    

    var body: some View {
        VStack{
            List(fetchRequest.wrappedValue, id: \.self) { Kelas in
                Text("\(Kelas.namaKelas)")
            }
            
            Button("add Examples"){
                let taylor = Kelas(context: self.moc)
                taylor.idKelas = UUID()
                taylor.namaKelas = "Kelas 1"
                taylor.idSekolah = self.sekolah.idSekolah
                
                do{
                    try self.moc.save()
                }catch{
                    print(error)
                }
            }
            
            HStack{
                SearchBar(text: $searchText)
            }
            
            VStack(spacing: 0){
                MainView(data: self.$data, Grid: self.$Grid)
            }
            .background(Color.black.opacity(0.06).edgesIgnoringSafeArea(.top))
            .edgesIgnoringSafeArea(.bottom)
            .onAppear {
                
                self.generateGrid()
            }
        }
            
        
        
            
        
        
        
        
//        ZStack{
//            VStack{
//                HStack{
//                    Text("Hello")
//                    Text("\(self.sekolah.idSekolah)")
//                }
//            }
//        }
    
            
//                                Text("\(sekolah.namaSekolah)")
//
//
//                            }
//                            List{
//                                ForEach(self.listOfKelas, id: \.idKelas){ item in
//                                        Text("\(item.namaKelas)")
//                                }
//                            }
//                        }
            .navigationBarTitle("Daftar Kelas")
            .navigationBarItems(trailing:
                Button(action: {
                    self.showingDetail.toggle()
                }) {
                    Image(systemName: "plus")
                        .foregroundColor(.orange)
                        .imageScale(.large)
                }.sheet(isPresented: $showingDetail) {
                    addClass()
                        .environment(\.managedObjectContext, self.moc)
                }
        )
        
        
    }
    
    func generateGrid(){
        
        for i in stride(from: 0, to: self.data.count, by: 2){
            
            if i != self.data.count{
                
                self.Grid.append(i)
            }
            
        }
    }
    
}

struct Card : View {
    
    var data : Type
    
    var body: some View{
        
        VStack(spacing: 15){
            
            Button(action: {
                
            }) {
                VStack{
                    Text(data.namaKelas)
//                        .bold()
                        .foregroundColor(.black)
                        .frame(width: (UIScreen.main.bounds.width - 70) / 3)
                        .padding(.vertical,10)
                        .padding(.top, 10)
                        
                    
                    Image(data.gambarKelas)
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: (UIScreen.main.bounds.width - 45) / 3)
                        .cornerRadius(12)
                        .padding(.bottom, 10)
                        
                }
                
                
            }.background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 6)
            
        }.padding(5)
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

                                Spacer(minLength: 0)
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
}


//struct pageDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        pageDetail(sekolah: Sekolah())
//    }
//}
