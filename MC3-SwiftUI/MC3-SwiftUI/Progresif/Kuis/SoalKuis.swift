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
    //    var lvl2 = ["LARI","POHON","MENYANYI","DIAM","SUSAH","GAMPANG","BUDI","BACA","PUTIH","BOLA"]
    var lvl2 = [
        SoalEjaan(soal: "LARI", ejaan: ["la","ri"]),
        SoalEjaan(soal: "POHON", ejaan: ["po","hon"]),
        SoalEjaan(soal: "MENYANYI", ejaan: ["me","nya","nyi"]),
        SoalEjaan(soal: "DIAM", ejaan: ["di","am"]),
        SoalEjaan(soal: "SUSAH", ejaan: ["su","sah"]),
        SoalEjaan(soal: "GAMPANG", ejaan: ["gam","pang"]),
        SoalEjaan(soal: "BUDI", ejaan: ["bu","di"]),
        SoalEjaan(soal: "BACA", ejaan: ["ba","ca"]),
        SoalEjaan(soal: "PUTIH", ejaan: ["pu","tih"]),
        SoalEjaan(soal: "BOLA", ejaan: ["bo","la"]),
    ]
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
    
//    public func randomizeSoal(level : Int) -> String {
//        switch level {
//        case 1:
//            return lvl1.randomElement() ?? ""
//        case 2:
//            return lvl2.randomElement() ?? ""
//        case 3:
//            return lvl3.randomElement() ?? ""
//        case 4:
//            return lvl4.randomElement() ?? ""
//        default:
//            return ""
//        }
//    }
    
    public func randomizeSoalStruct(level : Int) -> SoalEjaan {
        switch level {
//        case 1:
//            return lvl1.randomElement() ?? SoalEjaan(soal: "", ejaan: [])
        case 2:
            return lvl2.randomElement() ?? SoalEjaan(soal: "", ejaan: [])
//        case 3:
//            return lvl3.randomElement() ?? SoalEjaan(soal: "", ejaan: [])
//        case 4:
//            return lvl4.randomElement() ?? SoalEjaan(soal: "", ejaan: [])
        default:
            return SoalEjaan(soal: "", ejaan: [])
        }
    }
}

public struct SoalEjaan {
    var soal : String = ""
    var ejaan : [String] = []
}
