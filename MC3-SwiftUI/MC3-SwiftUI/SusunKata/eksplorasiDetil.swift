//
//  eksplorasiDetil.swift
//  MC3-SwiftUI
//
//  Created by Reyhan Rifqi on 03/08/20.
//  Copyright © 2020 Poppy. All rights reserved.
//

import SwiftUI

struct eksplorasiDetil: View {
        @Environment(\.managedObjectContext) var moc
        
        @ObservedObject var eksplorasi: Eksplorasi
        var eksplorasiView: SusunKataView
        
        init(eksplorasi: Eksplorasi, eksplorasiView: SusunKataView) {
            self.eksplorasi = eksplorasi
            self.eksplorasiView = eksplorasiView
        }
        
        var body: some View {
            ZStack{
                Image(self.eksplorasi.isSelected ? "eksplorasi-aktif" : "eksplorasi-default")
                    .resizable()
                .frame(width: 86, height: 86, alignment: .center)

                     
                Text("\(eksplorasi.sukuKata)")
                    .font(.system(size: 35, weight: .bold, design: .default))
                    .foregroundColor(.black)
                    .offset(x: 2)
             }
                .onTapGesture {
                    if self.eksplorasiView.queue.count < 6{
                        self.eksplorasi.isSelected = true
                        if self.eksplorasiView.textField == ""{
                            self.eksplorasiView.textField += "\(self.eksplorasi.sukuKata)"
    
                        }else{
                            self.eksplorasiView.textField += " - \(self.eksplorasi.sukuKata)"
                        }
                        self.eksplorasiView.queue.append(self.eksplorasi.sukuKata)
                    }
                 }
            
            .accessibility(label: Text("\(eksplorasi.sukuKata)"))
    }
}

//struct eksplorasiDetil_Previews: PreviewProvider {
//    static var previews: some View {
//        eksplorasiDetil()
//    }
//}
