//
//  KuisView.swift
//  MC3-SwiftUI
//
//  Created by Poppy on 21/07/20.
//  Copyright © 2020 Poppy. All rights reserved.
//

import SwiftUI
import Combine
import Speech


struct KuisView: View {
//    var delegate: DismissRequestDelegate?
    @Environment(\.presentationMode) var presentationMode
    
    var namaMurid = "Agus"
    var levelMurid = 2
    var soalKuis = SoalKuis()
    @State var daftarMurid : [TypeMurid]
    
    @State var soalEjaan = SoalEjaan()
    @State var resultString : String = ""
    @State var isRecording : Bool = false
    @State var showEjaan : Bool = false
    @State var idxEjaan : Int = 0
    @State var soal : String = "Lari"
    @State var ejaan = ["la","ri"]
    @State var isAnswered : Bool = false
    @State var answeredEjaan = Ejaan()
    @State var soalIdx = 0
    @State var tempCorrect = false
    @State var finalVerdict = false
    @State var sukuKata1Lvl3 : String = ""
    @State var sukuKata2Lvl3 : String = ""
    @State var resultEjaanLvl4 : [String] = []
    @State var tempString = ""
    @State var limit = 0
    @State var tempScore : Double = 0
    @State var score : Int64 = 0
    @State var indexMurid : Int = 0
    @State var idKuis = UUID()
    
    @Environment(\.managedObjectContext) var moc
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    var soundClassification = SoundClassification()
    
    func setKuisToCoreData() {
        let jawaban = Jawaban(context: self.moc)
        let kuis = Kuis(context: self.moc)
        jawaban.ejaan = self.soal
        jawaban.score = self.score
        let id = UUID()
        jawaban.idJawaban = id
        jawaban.idKuis = self.idKuis
        kuis.idKuis = self.idKuis
        kuis.idMurid = daftarMurid[indexMurid].idMurid
        kuis.tanggalKuis = Date()
        do{
            try self.moc.save()
            print("Sukses set kuis to core data")
        }catch{
            print(error.localizedDescription)
        }
    }
    
    func calculateScore() {
        tempScore = 0
        for answer in answeredEjaan.isCorrect{
            if answer{
                tempScore += 1
            }
        }
        tempScore /= Double(answeredEjaan.isCorrect.count)
        score = Int64(tempScore * 100)
        print("Score : \(score)")
        setKuisToCoreData()
    }
    
    func showResultLevel1(resultString:String, soal:String) {
        answeredEjaan.sukuKata = ejaan
        if resultString.uppercased() == soal.uppercased() {
            answeredEjaan.isCorrect.append(true)
            finalVerdict = true
        }else{
            answeredEjaan.isCorrect.append(false)
            finalVerdict = false
        }
        calculateScore()
    }
    
    func showResultLevel2(resultString:String, soal:String, soalEjaan : SoalEjaan) {
        if(resultString.uppercased() == soal.uppercased()){
            answeredEjaan.sukuKata = ejaan
            for _ in ejaan{
                answeredEjaan.isCorrect.append(true)
            }
            finalVerdict = true
        }
        else if(resultString.count == soal.count){
            soalIdx = 0
            for eja in ejaan{
                tempCorrect = false
                idxEjaan = 0
                for alfabet in eja{
                    if(alfabet.uppercased() == resultString[resultString.index(resultString.startIndex, offsetBy: soalIdx)].uppercased()){
                        if(idxEjaan == 0){
                            tempCorrect = true
                        }else{
                            if(!tempCorrect){
                                tempCorrect = false
                            }else{
                                tempCorrect = true
                            }
                        }
                    }else{
                        if(idxEjaan == 0){
                            tempCorrect = false
                        }else{
                            if(tempCorrect){
                                tempCorrect = false
                            }else{
                                tempCorrect = true
                            }
                        }
                    }
                    soalIdx+=1
                    idxEjaan+=1
                }
                answeredEjaan.sukuKata.append(eja)
                answeredEjaan.isCorrect.append(tempCorrect)
            }
        }
        else{
            answeredEjaan.sukuKata = ejaan
            for _ in ejaan{
                answeredEjaan.isCorrect.append(false)
            }
            finalVerdict = false
        }
        calculateScore()
    }
    
    func showResultLevel3(resultString:String, soal:String, soalEjaan : SoalEjaan) {
        if(resultString.uppercased() == soal.uppercased()){
            answeredEjaan.sukuKata = ejaan
            for _ in ejaan{
                answeredEjaan.isCorrect.append(true)
            }
            finalVerdict = true
        }
        else if(resultString.count == soal.count){
            soalIdx = 0
            for eja in ejaan{
                tempCorrect = false
                idxEjaan = 0
                for alfabet in eja{
                    if(alfabet.uppercased() == resultString[resultString.index(resultString.startIndex, offsetBy: soalIdx)].uppercased()){
                        print("bener di \(alfabet)")
                        if(idxEjaan == 0){
                            tempCorrect = true
                        }else{
                            if(!tempCorrect){
                                tempCorrect = false
                            }else{
                                tempCorrect = true
                            }
                        }
                    }else{
                        print("salah di \(alfabet)")
                        if(idxEjaan == 0){
                            tempCorrect = false
                        }else{
                            if(tempCorrect){
                                tempCorrect = false
                            }else{
                                tempCorrect = true
                            }
                        }
                    }
                    soalIdx+=1
                    idxEjaan+=1
                }
                answeredEjaan.sukuKata.append(eja)
                answeredEjaan.isCorrect.append(tempCorrect)
            }
        }else if(resultString.count != soal.count && (resultString.firstIndex(of: " ") != nil)){
            if let spaceIdxLvl3 = soal.firstIndex(of: " "){
                sukuKata1Lvl3 = String(soal[soal.startIndex..<soal.index(before:spaceIdxLvl3)])
                sukuKata2Lvl3 = String(soal[soal.index(after: spaceIdxLvl3)..<soal.endIndex])
                
                if(ejaan[0].uppercased() == sukuKata1Lvl3.uppercased()){
                    answeredEjaan.sukuKata.append(ejaan[0])
                    answeredEjaan.isCorrect.append(true)
                }else{
                    answeredEjaan.sukuKata.append(ejaan[0])
                    answeredEjaan.isCorrect.append(false)
                }
                
                if(ejaan[1].uppercased() == sukuKata2Lvl3.uppercased()){
                    answeredEjaan.sukuKata.append(ejaan[1])
                    answeredEjaan.isCorrect.append(true)
                }else{
                    answeredEjaan.sukuKata.append(ejaan[1])
                    answeredEjaan.isCorrect.append(false)
                }
                
            }
            
        }
        else{
            answeredEjaan.sukuKata = ejaan
            for _ in ejaan{
                answeredEjaan.isCorrect.append(false)
            }
            finalVerdict = false
        }
        calculateScore()
    }
    
    func showResultLevel4(resultString:String, soal:String, soalEjaan : SoalEjaan) {
        if(resultString.uppercased() == soal.uppercased()){
            answeredEjaan.sukuKata = ejaan
            for _ in ejaan{
                answeredEjaan.isCorrect.append(true)
            }
            finalVerdict = true
        }
        else {
            finalVerdict = false
            
            tempString = ""
            resultEjaanLvl4 = []
            for char in resultString{
                if char != " "{
                    tempString.append(char)
                }else{
                    resultEjaanLvl4.append(tempString)
                    tempString = ""
                }
            }
            soalIdx = 0
            for eja in resultEjaanLvl4{
                answeredEjaan.sukuKata.append(ejaan[soalIdx])
                if eja.uppercased() == ejaan[soalIdx].uppercased() {
                    answeredEjaan.isCorrect.append(true)
                }else{
                    answeredEjaan.isCorrect.append(false)
                }
                soalIdx += 1
            }
        }
        calculateScore()
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack{
                Rectangle()
                    .foregroundColor(Color(red: 1.00, green: 0.81, blue: 0.42))
                RoundedRectangle(cornerRadius: 80)
                    .foregroundColor(.white)
                    .frame(width: screenWidth, height: screenHeight)
                    .position(x: screenWidth / 3, y: screenHeight / 3)
                VStack{
                    HStack{
                        Button(action: {
                            //                            self.showKuisView = false
                        }) {
                            HStack{
                                Image(systemName: "chevron.left")
                                    .foregroundColor(Color(red: 0.79, green: 0.26, blue: 0.00))
                                Text("Keluar Kuis")
                                    .font(.custom("SF Compact Text", size: 17))
                                    .foregroundColor(Color(red: 0.79, green: 0.26, blue: 0.00))
                                .onTapGesture {
//                                    self.delegate?.requestDismiss()
                                    self.presentationMode.wrappedValue.dismiss()
                                }
                                    
                            }
                            .accessibility(label: Text("Keluar kuis"))
                            
                        }
                        Spacer()
                        Text(daftarMurid[indexMurid].namaMurid)
                            .fontWeight(.bold)
                            .font(.system(size: 17))
                            .font(.custom("SF Compact Text", size: 17))
                            .foregroundColor(.black)
                            .accessibility(label: Text(namaMurid))
                        Spacer()
                        Button(action: {
                            //
                        }) {
                            HStack{
                                if indexMurid < daftarMurid.count-1{
                                    Text("Lewati Murid")
                                        .foregroundColor(Color(red: 0.79, green: 0.26, blue: 0.00))
                                        .fontWeight(.bold)
                                        .font(.system(size: 17))
                                        .font(.custom("SF Compact Text", size: 17))
                                        .accessibility(label: Text("Lewati murid"))
                                        .onTapGesture {
                                            self.indexMurid += 1
                                            self.idKuis = UUID()
                                    }
                                }else{
                                    Text("Lewati Murid")
                                        .foregroundColor(Color(red: 0.79, green: 0.26, blue: 0.00))
                                        .fontWeight(.bold)
                                        .font(.system(size: 17))
                                        .opacity(0)
                                        .font(.custom("SF Compact Text", size: 17))
                                        .accessibility(label: Text("Lewati Murid"))
                                        .onTapGesture {
                                            self.presentationMode.wrappedValue.dismiss()
                                    }
                                }
                            }
                            
                        }
                    }
                    .padding(20)
                    
                    Spacer()
                    
                    Image(soal.lowercased())
                        .padding(.top, -90)
                    
                    Text(soal.uppercased())
                        .fontWeight(.bold)
                        .font(.system(size: 57))
                        .font(.custom("SF Compact Text", size: 57))
                        .foregroundColor(.black)
                    
                    if(self.showEjaan == true){
                        if(self.finalVerdict){
                            HStack{
                                ForEach(ejaan, id :\.self){ eja in
                                    Text("\(eja) •")
                                        .font(.system(size: 28))
                                        .font(.custom("SF Compact Text", size: 28))
                                        .foregroundColor(.black)
                                        .accessibility(label: Text(self.soal.lowercased()))
                                }
                                Image("ceklis").resizable()
                                    .frame(width: 28, height: 28, alignment: .center)
                                    .opacity(1)
                                    .accessibility(label: Text(soal.lowercased()))
                            }
                            .padding(.top, -20)
                        }else{
                            HStack{
                                ForEach(answeredEjaan.sukuKata.indices){ i in
                                    if(self.answeredEjaan.isCorrect[i]){
                                        Text("\(self.answeredEjaan.sukuKata[i]) •")
                                            .font(.system(size: 28))
                                            .font(.custom("SF Compact Text", size: 28))
                                            .foregroundColor(.black)
                                            .accessibility(label: Text(self.soal.lowercased()))
                                    }else{
                                        Text("\(self.answeredEjaan.sukuKata[i]) •")
                                            .font(.system(size: 28))
                                            .font(.custom("SF Compact Text", size: 28))
                                            .foregroundColor(.red)
                                            .accessibility(label: Text(self.soal.lowercased()))
                                    }
                                }
                                Image("ceklis").resizable()
                                    .frame(width: 28, height: 28, alignment: .center)
                                    .opacity(0)
                            }
                            .padding(.top, -20)
                        }
                    }else{
                        HStack{
                            
                            Text(" ")
                                .font(.system(size: 28))
                                .font(.custom("SF Compact Text", size: 28))
                                .foregroundColor(.black)
                            
                            Image("ceklis").resizable()
                                .frame(width: 28, height: 28, alignment: .center)
                                .opacity(0)
                        }
                        .padding(.top, -20)
                    }
                    
                    if(self.isAnswered == false){
                        if(self.isRecording == true){
                            Button(action: {
                                self.resultString =  self.soundClassification.stopRecording()
                                self.isRecording = false
                                self.showEjaan = true
                                self.isAnswered = true
                                if self.levelMurid == 1{
                                    self.showResultLevel1(resultString: self.resultString, soal: self.soal)
                                }else if self.levelMurid == 2{
                                    self.showResultLevel2(resultString: self.resultString, soal: self.soal, soalEjaan: self.soalEjaan)
                                }else if self.levelMurid == 3{
                                    self.showResultLevel3(resultString: self.resultString, soal: self.soal, soalEjaan: self.soalEjaan)
                                }else if self.levelMurid == 4{
                                    self.showResultLevel4(resultString: self.resultString, soal: self.soal, soalEjaan: self.soalEjaan)
                                }
                            }){
                                Image("stop-button")
                            }
                            .accessibility(label: Text("Hentikan Rekaman"))
                        }else{
                            Button(action: {
                                
                                self.soundClassification.recordAndRecognizeSpeech()
                                self.isRecording = true
                                self.showEjaan = false
                                self.answeredEjaan = Ejaan()
                                self.finalVerdict = false
                            }){
                                Image("record-button")
                            }
                            .accessibility(label: Text("Mulai Rekam"))
                            
                        }
                    }else{
                        if limit < 3{
                            Button(action: {
                                self.isAnswered = false
                                self.soalEjaan = self.soalKuis.randomizeSoalStruct(level: self.levelMurid)
                                self.soal = self.soalEjaan.soal
                                self.ejaan = self.soalEjaan.ejaan.sukuKata
                                self.showEjaan = false
                                self.limit += 1
                            }){
                                Image("ejaan-selanjutnya")
                            }
                            .accessibility(label: Text("Ejaan Selanjutnya"))
                        }else{
                            if indexMurid < daftarMurid.count-1{
                                Button(action: {
                                    self.indexMurid += 1
                                    self.idKuis = UUID()
                                    self.limit = 0
                                    self.isAnswered = false
                                    self.showEjaan = false
                                }){
                                    Image("murid-selanjutnya")
                                }
                                .accessibility(label: Text("Murid Selanjutnya"))
                            }else{
                                Button(action: {
                                    self.presentationMode.wrappedValue.dismiss()
                                }){
                                    Image("selesaikan-kuis")
                                }
                                .accessibility(label: Text("Selesai"))
                            }
                        }
                    }
                    
                    Spacer()
                }
            }
        }
    }
}


//struct KuisView_Previews: PreviewProvider {
//    @State static var showKuisView = true
//
//    static var previews: some View {
//        //        KuisView(showKuisView: $showKuisView)
////        KuisView()
//    }
//}

extension KuisView: SoundClassifierDelegate {
    func displayPredictionResult(identifier: String, confidence: Double) {
        DispatchQueue.main.async {
            print("Recognition: \(identifier)\nConfidence \(confidence)")
        }
    }
}

extension ForEach where Data.Element: Hashable, ID == Data.Element, Content: View {
    init(values: Data, content: @escaping (Data.Element) -> Content) {
        self.init(values, id: \.self, content: content)
    }
}
