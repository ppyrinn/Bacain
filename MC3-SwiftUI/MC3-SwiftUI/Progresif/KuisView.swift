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
    
    var soundClassification = SoundClassification()
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack{
                VStack{
                    HStack{
                        Button(action: {
//                            self.showKuisView = false
                        }) {
                            HStack{
                                Image(systemName: "chevron.left")
                                Text("Keluar Kuis").font(Font.custom("SF Compact Text", size: 17))
                            }
                            
                        }
                        Spacer()
                        Text(namaMurid).font(Font.custom("SF Compact Text", size: 17))
                        Spacer()
                        Button(action: {
                            //
                        }) {
                            HStack{
                                Text("Lewati Murid")
                                    .font(Font.custom("SF Compact Text", size: 17))
                            }
                            
                        }
                    }
                    .padding(20)
                    Spacer()
                    
                    Text(soal).font(Font.custom("SF Compact Text", size: 57)).bold()
                    
                    
                    if(self.isRecording == true){
                        Button(action: {
                            self.resultString = self.soundClassification.stopRecording()
                            self.isRecording = false
                        }){
                            Text("Stop")
                        }
                        Text("Sedang mendengarkan...")
                    }else{
                        Button(action: {
                            self.soundClassification.recordAndRecognizeSpeech()
                            self.isRecording = true
                        }){
                            Text("Record")
                        }
                        Text("Hasil : " + resultString)
                        if(self.resultString.uppercased() == self.soal.uppercased()){
                            Text("KAMU BISA BACA!!!!!")
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

