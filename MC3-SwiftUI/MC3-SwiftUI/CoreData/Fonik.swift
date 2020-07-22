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
    public var title: String
    public var subTitle: String
    public var sound: String
//    public var selected: Bool

}

let listOfFonik: [Fonik] = [
    Fonik(alfabet: "A", gambar: "Gambar Anggur", gambarDesc: "Anggur", title: "Aa", subTitle: "a..a..a..", sound: "suara anggur"),
    Fonik(alfabet: "B", gambar: "Gambar Budi", gambarDesc: "Budi", title: "Bb", subTitle: "b..b..b..", sound: "suara Budi"),
    Fonik(alfabet: "C", gambar: "Gambar Cabai", gambarDesc: "Cabai", title: "Cc", subTitle: "c..c..c..", sound: "suara cabai"),
]

let susunKataTop = [
    "Ba", "ma", "ri", "Ju", "ga", "bo", "la", "bu", "lu", "pa", "ha", "du", "ri", "gi", "ku", "to", "pi", "ta", "mu", "ni", "gu", "he", "yo", "zo", "na", "ze", "ro"
]

func generateKata() -> [String]{
    var randomWord: [String] = []
    for _ in 0..<8{
        let random = susunKataTop.randomElement()!.capitalized
        randomWord.append(random)
    }
    return randomWord
}




