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
        SoalEjaan(soal: "LARI", ejaan: Ejaan(sukuKata: ["la","ri"], isCorrect: [false,false])),
        SoalEjaan(soal: "POHON", ejaan: Ejaan(sukuKata: ["po","hon"], isCorrect: [false,false])),
        SoalEjaan(soal: "MENYANYI", ejaan: Ejaan(sukuKata: ["me","nya","nyi"], isCorrect: [false,false,false])),
        SoalEjaan(soal: "DIAM", ejaan: Ejaan(sukuKata: ["di","am"], isCorrect: [false,false])),
        SoalEjaan(soal: "SUSAH", ejaan: Ejaan(sukuKata: ["su","sah"], isCorrect: [false,false])),
        SoalEjaan(soal: "GAMPANG", ejaan: Ejaan(sukuKata: ["gam","pang"], isCorrect: [false,false])),
        SoalEjaan(soal: "BUDI", ejaan: Ejaan(sukuKata: ["bu","di"], isCorrect: [false,false])),
        SoalEjaan(soal: "BACA", ejaan: Ejaan(sukuKata: ["ba","ca"], isCorrect: [false,false])),
        SoalEjaan(soal: "PUTIH", ejaan: Ejaan(sukuKata: ["pu","tih"], isCorrect: [false,false])),
        SoalEjaan(soal: "BOLA", ejaan: Ejaan(sukuKata: ["bo","la"], isCorrect: [false,false])),
    ]
//    var lvl3 = [
//        "jendela kamar",
//        "ruang tamu",
//        "kipas angin",
//        "baju kemeja",
//        "botol minum",
//        "pintu kayu",
//        "sandal jepit",
//        "tempat tidur",
//        "buku gambar",
//        "tas sekolah"
//    ]
    var lvl3 = [
        SoalEjaan(soal: "jendela kamar", ejaan: Ejaan(sukuKata: ["jendela","kamar"], isCorrect: [false,false])),
        SoalEjaan(soal: "ruang tamu", ejaan: Ejaan(sukuKata: ["ruang","tamu"], isCorrect: [false,false])),
        SoalEjaan(soal: "kipas angin", ejaan: Ejaan(sukuKata: ["kipas","angin"], isCorrect: [false,false])),
        SoalEjaan(soal: "baju kemeja", ejaan: Ejaan(sukuKata: ["baju","kemeja"], isCorrect: [false,false])),
        SoalEjaan(soal: "botol minum", ejaan: Ejaan(sukuKata: ["botol","minum"], isCorrect: [false,false])),
        SoalEjaan(soal: "pintu kayu", ejaan: Ejaan(sukuKata: ["pintu","kayu"], isCorrect: [false,false])),
        SoalEjaan(soal: "sandal jepit", ejaan: Ejaan(sukuKata: ["sandal","jepit"], isCorrect: [false,false])),
        SoalEjaan(soal: "tempat tidur", ejaan: Ejaan(sukuKata: ["tempat","tidur"], isCorrect: [false,false])),
        SoalEjaan(soal: "buku gambar", ejaan: Ejaan(sukuKata: ["buku","gambar"], isCorrect: [false,false])),
        SoalEjaan(soal: "tas sekolah", ejaan: Ejaan(sukuKata: ["tas","sekolah"], isCorrect: [false,false])),
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
            return lvl2.randomElement() ?? SoalEjaan(soal: "", ejaan: Ejaan(sukuKata: [], isCorrect: []))
        case 3:
            return lvl3.randomElement() ?? SoalEjaan(soal: "", ejaan: Ejaan(sukuKata: [], isCorrect: []))
//        case 4:
//            return lvl4.randomElement() ?? SoalEjaan(soal: "", ejaan: [])
        default:
            return SoalEjaan(soal: "", ejaan: Ejaan(sukuKata: [], isCorrect: []))
        }
    }
}

public struct SoalEjaan {
    var soal : String = ""
    var ejaan = Ejaan()
}

public struct Ejaan{
    var sukuKata : [String] = []
    var isCorrect : [Bool] = []
}
