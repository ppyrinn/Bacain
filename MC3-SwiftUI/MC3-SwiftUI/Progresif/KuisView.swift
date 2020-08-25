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
    var soal = "LARI"
    var ejaan = ["la","ri"]
    
    @State var resultString : String = ""
    @State var isRecording : Bool = false
    @State var showEjaan : Bool = false
    @State var idxEjaan : Int = 0
    
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
                    
                    Image("lari")
                    
                    Text(soal)
                        .fontWeight(.bold)
                        .font(.system(size: 57))
                        .font(.custom("SF Compact Text", size: 57))
                    
                    if(self.showEjaan == true){
                        HStack{
                            ForEach(ejaan, id :\.self){ eja in
                                Text("\(eja) •")
                                .font(.system(size: 28))
                                .font(.custom("SF Compact Text", size: 28))
                            }
                            if(self.resultString.uppercased() == self.soal.uppercased()){
                                Image("ceklis")
                            }
                        }
                    }
                    
                    
                    if(self.isRecording == true){
                        Button(action: {
                            self.resultString = self.soundClassification.stopRecording()
                            self.isRecording = false
                            self.showEjaan = true
                        }){
                            Image("stop-button")
                        }
                        Text("Sedang mendengarkan...")
                    }else{
                        Button(action: {
                            self.soundClassification.recordAndRecognizeSpeech()
                            self.isRecording = true
                        }){
                            Image("record-button")
                        }
//                        Text("Hasil : " + resultString)
                        
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

