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
    @FetchRequest(fetchRequest: Sekolah.getAllSekolah())
    var listOfSekolah: FetchedResults<Sekolah>
    
    @State private var newSekolah = ""
    @State var showingDetail = false
    @State private var searchText = ""
    
    var body: some View {
       NavigationView {
        
        List{
            Section(header: Text("Daftar Sekolah")) {
                ForEach(self.listOfSekolah, id: \.namaSekolah){ item in
                    NavigationLink(destination: pageDetail(filter: item.idSekolah.uuidString, sekolah: item)) {
                        Text("\(item.namaSekolah)")
                        
                    }
                    .padding(15)
                    .background(Color(red: 1.00, green: 0.81, blue: 0.42))
                    .cornerRadius(25)
                    
                }
                .onDelete(perform: deleteItem)
            }.accessibility(label: Text("Daftar Sekolah"))
        }
        .onAppear {
            UITableView.appearance().separatorStyle = .none
            
        }
            
        .navigationBarTitle("Progresif")
        .background(NavigationConfigurator { nc in
            nc.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.white]
        })
            
            

        .accessibility(label: Text("Progresif"))
        
        .navigationBarItems(trailing:
            Button(action: {
                self.showingDetail.toggle()
            }) {
                Text("Tambah Sekolah")
                    .foregroundColor(Color(red: 0.79, green: 0.26, blue: 0.0))
                    .imageScale(.large)
                    .accessibility(label: Text("Tambah Sekolah"))
            }.sheet(isPresented: $showingDetail) {
                addSchool()
                    .environment(\.managedObjectContext, self.moc)
            }
            
        )
        
        ZStack{
            VStack{
                Color(red: 1.00, green: 0.81, blue: 0.42)
                    .padding(.bottom, -20)
                Image("tambah-daftarsekolah")
                    .padding(.top, -550)
                Text("Kamu belum memilih/memiliki sekolah. Pilih/tambah sekolah terlebih dahulu.")
                    .bold()
                    .padding(.top, -200)
            }
        .navigationBarTitle("Daftar Kelas").accessibility(label: Text("Daftar Kelas"))

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

extension UINavigationController {
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}

struct NavigationConfigurator: UIViewControllerRepresentable {
    var configure: (UINavigationController) -> Void = { _ in }

    func makeUIViewController(context: UIViewControllerRepresentableContext<NavigationConfigurator>) -> UIViewController {
        UIViewController()
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<NavigationConfigurator>) {
        if let nc = uiViewController.navigationController {
            self.configure(nc)
        }
    }

}


struct addSchool: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @FetchRequest(fetchRequest: Sekolah.getAllSekolah()) var listOfSekolah: FetchedResults<Sekolah>
    
    @State private var newSekolah = ""
    @State private var showingAlert = false
    @State var value : CGFloat = 0
    @State private var buttonDisabled = true
    
    var body: some View {
        ZStack{
            VStack{
                
                HStack{
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Batal")
                            .bold()
                            .foregroundColor(Color(red: 0.79, green: 0.26, blue: 0.0))
                    }.accessibility(label: Text("Batal"))
                    Spacer()
                    
                    Button(action: {
                        if self.newSekolah == "" {
                            self.showingAlert = true
                            
                        }
                        else {
                            let sekolah = Sekolah(context: self.moc)
                            sekolah.namaSekolah = self.newSekolah
                            let id = UUID()
                            sekolah.idSekolah = id
                            
                            do{
                                try self.moc.save()
                            }catch{
                                print(error)
                            }
                            self.newSekolah = ""
                            self.presentationMode.wrappedValue.dismiss()
                        }
                        
                    }) {
                        if newSekolah.isEmpty {
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
                    .disabled(newSekolah.isEmpty)
                    
                }
                .padding(30)
                
                Spacer()
                
                VStack{
                    HStack{
                        Text("Tambah Sekolah")
                            .bold()
                            .font(.title)
                            .foregroundColor(Color(red: 0.79, green: 0.26, blue: 0.0))
                    }.accessibility(label: Text("Tambah Sekolah"))
                    HStack{
                        Text("Tambah sekolah yang ingin kamu simpan/pantau perkembangan muridnya")
                    }.accessibility(label: Text("Tambah sekolah yang ingin kamu simpan/pantau perkembangan muridnya"))
                    HStack{
                        Text("Sekolah")
                        .foregroundColor(Color(red: 0.79, green: 0.26, blue: 0.0))
                        .bold()
                        TextField("Nama Sekolah", text: self.$newSekolah)
                            .accessibility(label: Text("Masukkan sekolah Baru yang ingin ditambahkan"))
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onAppear {
                            UITableView.appearance().separatorStyle = .singleLine
                        }
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
        }
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ProgresifView()
    }
}
