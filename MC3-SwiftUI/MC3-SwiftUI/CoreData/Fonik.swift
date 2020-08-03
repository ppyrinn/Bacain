//
//  Fonik.swift
//  MC3-SwiftUI
//
//  Created by Reyhan Rifqi on 19/07/20.
//  Copyright © 2020 Poppy. All rights reserved.
//

import Foundation

struct Fonik{
    public var alfabet: String
    public var gambar: String
    public var gambarDesc: String
    public var subTitle: String
    public var isSelected: Bool

}

let listOfFonik: [Fonik] = [
    Fonik(alfabet: "A", gambar: "anggur", gambarDesc: "Anggur", subTitle: "a..a..a", isSelected: false),
    Fonik(alfabet: "B", gambar: "bunga", gambarDesc: "Bunga", subTitle: "beh..beh..beh", isSelected: false),
    Fonik(alfabet: "C", gambar: "capung", gambarDesc: "Capung", subTitle: "ceh..ceh..ceh", isSelected: false),
    Fonik(alfabet: "D", gambar: "dasi", gambarDesc: "Dasi", subTitle: "deh..deh..deh", isSelected: false),
    Fonik(alfabet: "E", gambar: "ember", gambarDesc: "Ember", subTitle: "e..e..e", isSelected: false),
    Fonik(alfabet: "F", gambar: "foto2", gambarDesc: "Foto", subTitle: "fff..fff..fff", isSelected: false),
    Fonik(alfabet: "G", gambar: "gitar", gambarDesc: "Gitar", subTitle: "geh..geh..geh", isSelected: false),
    Fonik(alfabet: "H", gambar: "hotel", gambarDesc: "Hotel", subTitle: "hhh..hhh..hhh", isSelected: false),
    Fonik(alfabet: "I", gambar: "ibu", gambarDesc: "Ibu", subTitle: "i..i..i", isSelected: false),
    Fonik(alfabet: "J", gambar: "jambu", gambarDesc: "Jambu", subTitle: "jeh..jeh..jeh", isSelected: false),
    Fonik(alfabet: "K", gambar: "kereta", gambarDesc: "Kereta", subTitle: "keh..keh..keh", isSelected: false),
    Fonik(alfabet: "L", gambar: "lampu", gambarDesc: "Lampu", subTitle: "l..l..l", isSelected: false),
    Fonik(alfabet: "M", gambar: "mata", gambarDesc: "Mata", subTitle: "m..m..m", isSelected: false),
    Fonik(alfabet: "N", gambar: "nahkoda", gambarDesc: "Nahkoda", subTitle: "n..n..n", isSelected: false),
    Fonik(alfabet: "O", gambar: "obat", gambarDesc: "Obat", subTitle: "o..o..o", isSelected: false),
    Fonik(alfabet: "P", gambar: "pesawat", gambarDesc: "Pesawat", subTitle: "peh..peh..peh", isSelected: false),
    Fonik(alfabet: "Q", gambar: "quran", gambarDesc: "Quran", subTitle: "kweh..kweh..kweh", isSelected: false),
    Fonik(alfabet: "R", gambar: "roti2", gambarDesc: "Roti", subTitle: "rrr..rrr..rrr", isSelected: false),
    Fonik(alfabet: "S", gambar: "sepatu", gambarDesc: "Sepatu", subTitle: "sss..sss..sss", isSelected: false),
    Fonik(alfabet: "T", gambar: "tangga-", gambarDesc: "Tangga", subTitle: "teh..teh..teh", isSelected: false),
    Fonik(alfabet: "U", gambar: "ular", gambarDesc: "Ular", subTitle: "u..u..u..", isSelected: false),
    Fonik(alfabet: "V", gambar: "vanili", gambarDesc: "Vanili", subTitle: "veh..veh..veh", isSelected: false),
    Fonik(alfabet: "W", gambar: "wajan 2", gambarDesc: "Wajan", subTitle: "weh..weh..weh..", isSelected: false),
    Fonik(alfabet: "X", gambar: "xilofon", gambarDesc: "Xilofon", subTitle: "kes..kes..kes", isSelected: false),
    Fonik(alfabet: "Y", gambar: "yogurt@3x", gambarDesc: "Yogurt", subTitle: "yeh..yeh..yeh", isSelected: false),
    Fonik(alfabet: "Z", gambar: "zebra", gambarDesc: "Zebra", subTitle: "zzz..zzz..zzz", isSelected: false)

]

struct susunKata {
    public var sukuKata: String
    public var isSelected: Bool

}
var ArrsusunKata: [susunKata] = [
    susunKata(sukuKata: "Bo", isSelected: false), susunKata(sukuKata: "Ma", isSelected: false), susunKata(sukuKata: "Ta", isSelected: false),
    susunKata(sukuKata: "Mu", isSelected: false), susunKata(sukuKata: "Lu", isSelected: false), susunKata(sukuKata: "Zo", isSelected: false),
    susunKata(sukuKata: "La", isSelected: false), susunKata(sukuKata: "Ni", isSelected: false), susunKata(sukuKata: "Ra", isSelected: false),
    susunKata(sukuKata: "Pi", isSelected: false), susunKata(sukuKata: "Gu", isSelected: false), susunKata(sukuKata: "Ku", isSelected: false),
    susunKata(sukuKata: "Ga", isSelected: false), susunKata(sukuKata: "Bu", isSelected: false), susunKata(sukuKata: "Na", isSelected: false),
    susunKata(sukuKata: "Ja", isSelected: false), susunKata(sukuKata: "Pa", isSelected: false), susunKata(sukuKata: "Ha", isSelected: false),
    susunKata(sukuKata: "Ju", isSelected: false), susunKata(sukuKata: "He", isSelected: false), susunKata(sukuKata: "Yo", isSelected: false),
    susunKata(sukuKata: "Sa", isSelected: false), susunKata(sukuKata: "Pu", isSelected: false), susunKata(sukuKata: "Ba", isSelected: false),
    susunKata(sukuKata: "Gi", isSelected: false), susunKata(sukuKata: "Ro", isSelected: false), susunKata(sukuKata: "To", isSelected: false),
    susunKata(sukuKata: "Ra", isSelected: false), susunKata(sukuKata: "Du", isSelected: false), susunKata(sukuKata: "Li", isSelected: false),
    susunKata(sukuKata: "Zi", isSelected: false)
]

var eksplorasiTop: [Eksplorasi] = []
var eksplorasiBot: [Eksplorasi] = []



