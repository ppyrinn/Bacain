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
//    @Binding var showKuisView: Bool
    
    var namaMurid = "Agus"
    var soalLvl2 = ["LARI","POHON","MENYANYI","DIAM","SUSAH","GAMPANG","BUDI","BACA","PUTIH","BOLA"]
    var ejaan = ["la","ri"]
    var soalKuis = SoalKuis()
    
    @State var resultString : String = ""
    @State var isRecording : Bool = false
    @State var showEjaan : Bool = false
    @State var idxEjaan : Int = 0
    @State var soal : String = "Lari"
    @State var isAnswered : Bool = false
    
    var soundClassification = SoundClassification()
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack{
                Rectangle()
                    .foregroundColor(Color(red: 1.00, green: 0.81, blue: 0.42))
                RoundedRectangle(cornerRadius: 80)
                    .foregroundColor(.white)
                    .frame(height: 800)
                    .position(x: 596, y: 300)
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
                            }
                            
                        }
                        Spacer()
                        Text(namaMurid)
                            .fontWeight(.bold)
                            .font(.system(size: 17))
                            .font(.custom("SF Compact Text", size: 17))
                            .foregroundColor(.black)
                        Spacer()
                        Button(action: {
                            //
                        }) {
                            HStack{
                                Text("Lewati Murid")
                                    .foregroundColor(Color(red: 0.79, green: 0.26, blue: 0.00))
                                    .fontWeight(.bold)
                                    .font(.system(size: 17))
                                    .font(.custom("SF Compact Text", size: 17))
                            }
                            
                        }
                    }
                    .padding(20)
                    
                    Spacer()
                    
//                    self.soal = soalKuis.randomizeSoal(level : 1)
                    
                    Image(soal.lowercased()).padding(.top, -90)
                    
                    Text(soal.uppercased())
                        .fontWeight(.bold)
                        .font(.system(size: 57))
                        .font(.custom("SF Compact Text", size: 57))
                        .foregroundColor(.black)
                    
                    if(self.showEjaan == true){
                        HStack{
                            ForEach(ejaan, id :\.self){ eja in
                                Text("\(eja) •")
                                    .font(.system(size: 28))
                                    .font(.custom("SF Compact Text", size: 28))
                                    .foregroundColor(.black)
                            }
                            Image("ceklis").resizable()
                            .frame(width: 28, height: 28, alignment: .center)
                            .opacity(0)
                            if(self.resultString.uppercased() == self.soal.uppercased()){
                                Image("ceklis").resizable()
                                .frame(width: 28, height: 28, alignment: .center)
                                .opacity(1)
                            }
                        }
                        .padding(.top, -20)
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
                            }){
                                Image("stop-button")
                            }
                        }else{
                            Button(action: {
                                
                                self.soundClassification.recordAndRecognizeSpeech()
                                self.isRecording = true
                                self.showEjaan = false
                            }){
                                Image("record-button")
                            }
                            //                        Text("Hasil : " + resultString)
                            
                        }
                    }else{
                        Button(action: {
                            self.isAnswered = false
                            self.soal = self.soalKuis.randomizeSoal(level : 2)
                        }){
                            Image("ejaanselanjutnya-button")
                        }
                    }
                    
                    Spacer()
                }
            }
        }
    }
}


struct KuisView_Previews: PreviewProvider {
    @State static var showKuisView = true
    
    static var previews: some View {
//        KuisView(showKuisView: $showKuisView)
        KuisView()
    }
}

extension KuisView: SoundClassifierDelegate {
    func displayPredictionResult(identifier: String, confidence: Double) {
        DispatchQueue.main.async {
            print("Recognition: \(identifier)\nConfidence \(confidence)")
        }
    }
}
