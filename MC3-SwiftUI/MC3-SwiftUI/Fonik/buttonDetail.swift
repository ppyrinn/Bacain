//
//  buttonDetail.swift
//  MC3-SwiftUI
//
//  Created by Reyhan Rifqi on 03/08/20.
//  Copyright © 2020 Poppy. All rights reserved.
//

import SwiftUI

struct buttonDetail: View {
    @Environment(\.managedObjectContext) var moc
    
    @ObservedObject var fonik: FonikCD
    var fonikView: FonikView
    
    init(fonik: FonikCD, fonikView: FonikView) {
        self.fonik = fonik
        self.fonikView = fonikView
    }
    
    var body: some View {
        ZStack{
            Image(self.fonik.isSelected ? "fonik-aktif" : "fonik-default")
                .resizable()
                .frame(width: 50, height: 50, alignment: .center)
            Text("\(fonik.alfabet)")
                .font(.system(size: 28, weight: .bold, design: .default))
                .foregroundColor(.black)
                .offset(x: 2)
         }.onTapGesture {
                self.fonikView.resetisSelected()
                 player.stop()
                self.fonik.isSelected = true
                self.fonikView.gambar = self.fonik.gambar
                self.fonikView.gambarDesc = "\(self.fonik.gambarDesc)"
                self.fonikView.gambar = "\(self.fonik.gambar)"
                self.fonikView.title = "\(self.fonik.alfabet + self.fonik.alfabet.lowercased())"
                self.fonikView.subTitle = self.fonik.subTitle
                self.fonikView.sound = "\(self.fonik.alfabet)"
         }
        
        .accessibility(label: Text("\(fonik.alfabet)"))
        .frame(width: 44, height: 44, alignment: .center)
    }
}
