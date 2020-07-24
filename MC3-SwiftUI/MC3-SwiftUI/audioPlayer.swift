//
//  audioPlayer.swift
//  MC3-SwiftUI
//
//  Created by Reyhan Rifqi on 23/07/20.
//  Copyright © 2020 Poppy. All rights reserved.
//

import AVFoundation

var player = AVAudioPlayer()

func playFonik(title: String){

    guard let path = Bundle.main.path(forResource: title, ofType: "m4a")  else {return}
    print(path)
            do{
                player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                //player.play()

            }catch{
                print(error)
            }
    }
