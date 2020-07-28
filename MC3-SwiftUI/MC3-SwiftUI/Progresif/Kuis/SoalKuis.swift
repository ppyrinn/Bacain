//
//  SoalKuis.swift
//  MC3-SwiftUI
//
//  Created by Poppy on 27/07/20.
//  Copyright © 2020 Poppy. All rights reserved.
//

import Foundation

public class SoalKuis{
    var lvl1 = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    var lvl2 = ["LARI","POHON","MENYANYI","DIAM","SUSAH","GAMPANG","BUDI","BACA","PUTIH","BOLA"]
    var lvl3 = [
        "jendela kamar",
        "ruang tamu",
        "kipas angin",
        "baju kemeja",
        "botol minum",
        "pintu kayu",
        "sandal jepit",
        "tempat tidur",
        "buku gambar",
        "tas sekolah"
    ]
    var lvl4 = [
        "ini bapak budi",
        "saya suka baca",
        "ibu masak nasi",
        "bapak baca koran",
        "budi lari pagi",
        "dina pakai baju",
        "bunga itu indah",
        "sepeda roda dua",
        "tuti makan bubur",
        "adi main bola"
    ]
    
    public func randomizeSoal(level : Int) -> String {
        switch level {
        case 1:
            return lvl1.randomElement() ?? ""
        case 2:
            return lvl2.randomElement() ?? ""
        case 3:
            return lvl3.randomElement() ?? ""
        case 4:
            return lvl4.randomElement() ?? ""
        default:
            return ""
        }
    }
}
