////
////  SearchBarMurid.swift
////  MC3-SwiftUI
////
////  Created by Muhamad Vicky on 03/08/20.
////  Copyright © 2020 Poppy. All rights reserved.
////
//
//import SwiftUI
//
//struct SearchBarMurid: View {
//    @Environment(\.managedObjectContext) var moc
//    
//    @State var text = ""
//    @State var data : [TypeMurid] = []
//    @State var Grid : [Int] = []
//    @State private var isEditing = false
//    var murid: TypeMurid
//    
//    var fetchRequest: FetchRequest<Murid>
////    var murid: Murid
//    
////    init() {
////        onChangeInit(filter: text)
////    }
//    
//    func onChangeInit(filter: String) {
//        var fetchRequest = FetchRequest<Murid>(entity: Murid.entity(), sortDescriptors: [], predicate: NSPredicate(format: "namaMurid = %@", filter))
//        
//    }
////
//    func appendData(){
//        data.removeAll()
//        for murid in fetchRequest.wrappedValue {
//            data.append(TypeMurid(idMurid: murid.idMurid, namaMurid: murid.namaMurid, progress: murid.progress))
//        }
//    }
//    
//    var body: some View {
//        VStack{
//                HStack {
//                    //            Text(murid.namaMurid)
//                    TextField("Search ...", text: $text)
//                        .padding(7)
//                        .padding(.horizontal, 25)
//                        .background(Color(.systemGray6))
//                        .cornerRadius(8)
//                        .overlay(
//                            HStack {
//                                Image(systemName: "magnifyingglass")
//                                    .foregroundColor(.gray)
//                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
//                                    .padding(.leading, 8)
//                                
//                                if isEditing {
//                                    Button(action: {
//                                        self.text = ""
//                                    }) {
//                                        Image(systemName: "multiply.circle.fill")
//                                            .foregroundColor(.gray)
//                                            .padding(.trailing, 8)
//                                    }
//                                }
//                            }
//                    )
//                        .padding(.horizontal, 10)
//                        .onTapGesture {
//                            self.isEditing = true
//                            self.appendData()
//                    }
//                    
//                    if isEditing {
//                        Button(action: {
//                            self.isEditing = false
//                            self.text = ""
//                            
//                        }) {
//                            Text("Cancel")
//                        }
//                        .padding(.trailing, 10)
//                        .transition(.move(edge: .trailing))
//                        .animation(.default)
//                    }
//            }
//            
//            VStack(spacing: 0){
//                Main(data: self.$data, Grid: self.$Grid)
//            }
//
//        }
//                
//        
//        
//    }
//}
//
////struct SearchBarMurid_Previews: PreviewProvider {
////    static var previews: some View {
////        SearchBarMurid(text: .constant(""))
////    }
////}
