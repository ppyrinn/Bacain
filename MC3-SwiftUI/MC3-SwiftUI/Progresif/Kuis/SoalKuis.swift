//
//  SoalKuis.swift
//  MC3-SwiftUI
//
//  Created by Poppy on 27/07/20.
//  Copyright © 2020 Poppy. All rights reserved.
//

import Foundation

public class SoalKuis{
    var lvl1 = [
        SoalEjaan(soal: "A", ejaan: Ejaan(sukuKata: ["a"], isCorrect: [false])),
        SoalEjaan(soal: "B", ejaan: Ejaan(sukuKata: ["b"], isCorrect: [false])),
        SoalEjaan(soal: "C", ejaan: Ejaan(sukuKata: ["c"], isCorrect: [false])),
        SoalEjaan(soal: "D", ejaan: Ejaan(sukuKata: ["d"], isCorrect: [false])),
        SoalEjaan(soal: "E", ejaan: Ejaan(sukuKata: ["e"], isCorrect: [false])),
        SoalEjaan(soal: "F", ejaan: Ejaan(sukuKata: ["f"], isCorrect: [false])),
        SoalEjaan(soal: "G", ejaan: Ejaan(sukuKata: ["g"], isCorrect: [false])),
        SoalEjaan(soal: "H", ejaan: Ejaan(sukuKata: ["h"], isCorrect: [false])),
        SoalEjaan(soal: "I", ejaan: Ejaan(sukuKata: ["i"], isCorrect: [false])),
        SoalEjaan(soal: "J", ejaan: Ejaan(sukuKata: ["j"], isCorrect: [false])),
        SoalEjaan(soal: "K", ejaan: Ejaan(sukuKata: ["k"], isCorrect: [false])),
        SoalEjaan(soal: "L", ejaan: Ejaan(sukuKata: ["l"], isCorrect: [false])),
        SoalEjaan(soal: "M", ejaan: Ejaan(sukuKata: ["m"], isCorrect: [false])),
        SoalEjaan(soal: "N", ejaan: Ejaan(sukuKata: ["n"], isCorrect: [false])),
        SoalEjaan(soal: "O", ejaan: Ejaan(sukuKata: ["o"], isCorrect: [false])),
        SoalEjaan(soal: "P", ejaan: Ejaan(sukuKata: ["p"], isCorrect: [false])),
        SoalEjaan(soal: "Q", ejaan: Ejaan(sukuKata: ["q"], isCorrect: [false])),
        SoalEjaan(soal: "R", ejaan: Ejaan(sukuKata: ["r"], isCorrect: [false])),
        SoalEjaan(soal: "S", ejaan: Ejaan(sukuKata: ["s"], isCorrect: [false])),
        SoalEjaan(soal: "T", ejaan: Ejaan(sukuKata: ["t"], isCorrect: [false])),
        SoalEjaan(soal: "U", ejaan: Ejaan(sukuKata: ["u"], isCorrect: [false])),
        SoalEjaan(soal: "V", ejaan: Ejaan(sukuKata: ["v"], isCorrect: [false])),
        SoalEjaan(soal: "W", ejaan: Ejaan(sukuKata: ["w"], isCorrect: [false])),
        SoalEjaan(soal: "X", ejaan: Ejaan(sukuKata: ["x"], isCorrect: [false])),
        SoalEjaan(soal: "Y", ejaan: Ejaan(sukuKata: ["y"], isCorrect: [false])),
        SoalEjaan(soal: "Z", ejaan: Ejaan(sukuKata: ["z"], isCorrect: [false])),
    ]
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
        SoalEjaan(soal: "ini bapak budi", ejaan: Ejaan(sukuKata: ["ini","bapak","budi"], isCorrect: [false,false,false])),
        SoalEjaan(soal: "saya suka baca", ejaan: Ejaan(sukuKata: ["saya","suka","baca"], isCorrect: [false,false,false])),
        SoalEjaan(soal: "ibu masak nasi", ejaan: Ejaan(sukuKata: ["ibu","masak","nasi"], isCorrect: [false,false,false])),
        SoalEjaan(soal: "bapak baca koran", ejaan: Ejaan(sukuKata: ["bapak","baca","koran"], isCorrect: [false,false,false])),
        SoalEjaan(soal: "budi lari pagi", ejaan: Ejaan(sukuKata: ["budi","lari","pagi"], isCorrect: [false,false,false])),
        SoalEjaan(soal: "dina pakai baju", ejaan: Ejaan(sukuKata: ["dina","pakai","baju"], isCorrect: [false,false,false])),
        SoalEjaan(soal: "bunga itu indah", ejaan: Ejaan(sukuKata: ["bunga","itu","indah"], isCorrect: [false,false,false])),
        SoalEjaan(soal: "sepeda roda dua", ejaan: Ejaan(sukuKata: ["sepeda","roda","dua"], isCorrect: [false,false,false])),
        SoalEjaan(soal: "tuti makan bubur", ejaan: Ejaan(sukuKata: ["tuti","makan","bubur"], isCorrect: [false,false,false])),
        SoalEjaan(soal: "adi main bola", ejaan: Ejaan(sukuKata: ["adi","main","bola"], isCorrect: [false,false,false]))
    ]
    
    public func randomizeSoalStruct(level : Int) -> SoalEjaan {
        switch level {
        case 1:
            return lvl1.randomElement() ?? SoalEjaan(soal: "", ejaan: Ejaan(sukuKata: [], isCorrect: []))
        case 2:
            return lvl2.randomElement() ?? SoalEjaan(soal: "", ejaan: Ejaan(sukuKata: [], isCorrect: []))
        case 3:
            return lvl3.randomElement() ?? SoalEjaan(soal: "", ejaan: Ejaan(sukuKata: [], isCorrect: []))
        case 4:
            return lvl4.randomElement() ?? SoalEjaan(soal: "", ejaan: Ejaan(sukuKata: [], isCorrect: []))
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
