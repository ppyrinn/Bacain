//
//  DetailScoring.swift
//  MC3-SwiftUI
//
//  Created by Muhamad Vicky on 03/08/20.
//  Copyright © 2020 Poppy. All rights reserved.
//

import SwiftUI

struct TypeJawaban {
    var idKuis : UUID
    var ejaan : String
    var score : Int64
    var idJawaban : UUID
}

struct DetailScoring: View {
    @State var level = 1
    @State var progressValue: Float = 0.2
    @State var historyKuis : [Kuises] = []
    @State var listKuis: [Kuis] = []
    @State var listJawaban: [Jawaban] = []
    @State var dataJawaban : [TypeJawaban] = []
    @Environment(\.managedObjectContext) var moc
    
    var murid : TypeMurid
    
    
    init(data: TypeMurid){
        self.murid = data
    }
    
    func getKuisData(){
        var tempID : UUID = UUID()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, dd MMMM yyyy"
        dateFormatter.locale = Locale(identifier: "id")
        do{
            listKuis = try moc.fetch(Kuis.getKuisWithId(id: self.murid.idMurid))
        }catch{
            print("error when getKuisData \(error)")
        }
        historyKuis.removeAll()
        dataJawaban.removeAll()
        
        for kuis in listKuis {
            if(tempID != kuis.idKuis){
                tempID = kuis.idKuis
                historyKuis.append(Kuises(id: kuis.idKuis, tanggal:
                dateFormatter.string(from: kuis.tanggalKuis)))
                getJawabanData(idKuis: kuis.idKuis)
            }
            
        }
        print("\n\n\n=======\n\(historyKuis)\n======\n\n\n")
    }
    
    func getJawabanData(idKuis : UUID) {
        do{
            listJawaban = try moc.fetch(Jawaban.getJawabanWithId(id: idKuis))
        }catch{
            print("error when getJawabanData \(error)")
        }
        
        for jawaban in listJawaban {
            dataJawaban.append(TypeJawaban(idKuis: jawaban.idKuis, ejaan: jawaban.ejaan, score: jawaban.score, idJawaban: jawaban.idJawaban))
        }
        print("\n\n\n******\n\(dataJawaban)\n******\n\n\n")
    }
    
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(Color(red: 1.00, green: 0.81, blue: 0.42))
                .onAppear{
                    self.getKuisData()
            }
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
                        Text("Soal Kuis")
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
                    if historyKuis != []{
                        KuisListView(kuises: historyKuis, dataJawaban: dataJawaban)
                    }
                }
            }
            .navigationBarTitle(murid.namaMurid).accessibility(label: Text("Nama murid"))
        }
    }
}

//struct DetailScoring_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailScoring()
//    }
//}

struct Kuises : Identifiable, Hashable{
    var id:UUID
    var tanggal:String
}

struct KuisListView: View {
    let kuises: [Kuises]
    @State private var selection: Set<Kuises> = []
    let dataJawaban : [TypeJawaban]
    
    var body: some View {
        ScrollView {
            ForEach(kuises) { kuis in
                KuisDetailView(kuis: kuis, isExpanded: self.selection.contains(kuis), dataJawaban: self.dataJawaban)
                    .onTapGesture {
                        self.selectDeselect(kuis)
                }
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
    let dataJawaban : [TypeJawaban]
    
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
                Text("\(kuis.tanggal)")
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding(.leading, 20)
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
            }.padding(.bottom,10)
            .padding(.top,10)
            
            
            if isExpanded {
                ZStack{
                    Rectangle()
                        .foregroundColor(Color(red: 1.00, green: 0.87, blue: 0.61))
                    VStack(alignment: .leading) {
                        
                        ForEach(dataJawaban.indices){ i in
                            if(self.dataJawaban[i].idKuis == self.kuis.id){
                                HStack{
                                    Text("\(self.dataJawaban[i].ejaan.lowercased())")
                                        .foregroundColor(.black)
                                        .padding(.leading, 20)
                                    Spacer()
                                    Text("\(self.dataJawaban[i].score)")
                                        .foregroundColor(.black)
                                        .padding(.trailing,20)
                                }.padding(.bottom,20)
                                .padding(.top,20)
                            }
                        }
                    }
                }
            }
        }
    }
}
