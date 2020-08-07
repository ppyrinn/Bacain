//
//  DetailScoring.swift
//  MC3-SwiftUI
//
//  Created by Muhamad Vicky on 03/08/20.
//  Copyright © 2020 Poppy. All rights reserved.
//

import SwiftUI

struct DetailScoring: View {
    @State var level = 1
    @State var progressValue: Float = 0.2
    @State var historyKuis = [
        Kuises(id:0, tanggal:"20/2/2020", nilai:90),
        Kuises(id:1, tanggal:"21/2/2020", nilai:50),
        Kuises(id:2, tanggal:"22/2/2020", nilai:70),
        Kuises(id:3, tanggal:"23/2/2020", nilai:100)
    ]
    var murid : TypeMurid
    
    var fetchRequest: FetchRequest<Jawaban>
    
    init(data: TypeMurid){
//        self.idKelas = data.idKelas
        fetchRequest = FetchRequest<Jawaban>(entity: Jawaban.entity(), sortDescriptors: [], predicate: NSPredicate(format: "idMurid = %@", data.idMurid.uuidString))
        self.murid = data
        print("id \(data)")
        print("\(fetchRequest)")
    }
    
    var body: some View {
        ZStack{
            Rectangle()
            .foregroundColor(Color(red: 1.00, green: 0.81, blue: 0.42))
            VStack{
                Text("Level \(level)")
                    .font(.custom("SF Compact Text", size: 17))
                    .fontWeight(.bold)
                    .font(.system(size: 17))
                    .padding(.top, 50)
                    .foregroundColor(.black)
                ProgressBar(value: $progressValue).frame(height: 20)
                    .padding(.leading, 300)
                    .padding(.trailing, 300)
                    .padding(.top, 10)
                Spacer()
                VStack{
                    HStack{
                        Text("Level Kuis")
                        .foregroundColor(.black)
                        .font(.headline)
                        Spacer()
                        Text("Nilai")
                        .foregroundColor(.black)
                        .font(.headline)
                    }
                    .padding(.leading, 20)
                        .padding(.trailing, 20)
                    Divider()
                    KuisListView(kuises: historyKuis)
                }
            }
            .navigationBarTitle("Agus").accessibility(label: Text("Nama murid"))
        }
    }
}

//struct DetailScoring_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailScoring()
//    }
//}

struct Kuises : Identifiable, Hashable{
    var id:Int = 0
    var tanggal:String = ""
    var nilai:Int = 0
}

struct KuisListView: View {
    let kuises: [Kuises]
    @State private var selection: Set<Kuises> = []
    
    var body: some View {
        ScrollView {
            ForEach(kuises) { kuis in
                KuisDetailView(kuis: kuis, isExpanded: self.selection.contains(kuis))
                    .onTapGesture { self.selectDeselect(kuis) }
                    .modifier(ListRowModifier())
                    .animation(.linear(duration: 0.3))
            }
        }
    }
    
    private func selectDeselect(_ kuis: Kuises) {
        if selection.contains(kuis) {
            selection.remove(kuis)
        } else {
            selection.insert(kuis)
        }
    }
}

struct ListRowModifier: ViewModifier {
    func body(content: Content) -> some View {
        Group {
            content
            Divider()
        }
//        .offset(x: 20)
    }
}

struct KuisDetailView: View {
    let kuis: Kuises
    let isExpanded: Bool
    
    var body: some View {
        HStack {
            content
            Spacer()
        }
        .contentShape(Rectangle())
    }
    
    var content: some View {
        VStack(alignment: .leading) {
            HStack{
                Text("\(kuis.id+1)")
                .font(.headline)
                .foregroundColor(.black)
                .padding(.leading, 20)
                Spacer()
                Text("\(kuis.nilai)")
                .foregroundColor(.black)
                    .padding(.trailing, 20)
            }
            HStack{
                Text(kuis.tanggal)
                .padding(.leading, 20)
                .foregroundColor(.black)
                Spacer()
                if isExpanded{
                    Image(systemName: "chevron.up")
                    .font(.system(size: 17.0, weight: .bold))
                    .padding(.trailing, 20)
                    .foregroundColor(Color(red: 0.79, green: 0.26, blue: 0.00))
                }else{
                    Image(systemName: "chevron.down")
                    .font(.system(size: 17.0, weight: .bold))
                    .padding(.trailing, 20)
                    .foregroundColor(Color(red: 0.79, green: 0.26, blue: 0.00))
                }
            }
            
            if isExpanded {
                ZStack{
                    Rectangle()
                        .foregroundColor(Color(red: 1.00, green: 0.87, blue: 0.61))
                    VStack(alignment: .leading) {
                        HStack{
                            Text("la-ri")
                            .foregroundColor(.black)
                            .padding(.leading, 20)
                            Spacer()
                            Text("100")
                            .foregroundColor(.black)
                            .padding(.trailing,20)
                        }.padding(.bottom,20)
                            .padding(.top,20)
                        HStack{
                            Text("bu-di")
                            .foregroundColor(.black)
                            .padding(.leading, 20)
                            Spacer()
                            Text("50")
                            .foregroundColor(.black)
                            .padding(.trailing,20)
                        }.padding(.bottom,20)
                        HStack{
                            Text("me-nya-nyi")
                            .foregroundColor(.black)
                            .padding(.leading, 20)
                            Spacer()
                            Text("60")
                            .foregroundColor(.black)
                            .padding(.trailing,20)
                        }.padding(.bottom,20)
                        HStack{
                            Text("bo-la")
                            .foregroundColor(.black)
                            .padding(.leading, 20)
                            Spacer()
                            Text("100")
                            .foregroundColor(.black)
                            .padding(.trailing,20)
                        }.padding(.bottom,20)
                    }
                }
            }
        }
    }
}
