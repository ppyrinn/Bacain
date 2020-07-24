//
//  audioPlayer.swift
//  MC3-SwiftUI
//
//  Created by Reyhan Rifqi on 23/07/20.
//  Copyright © 2020 Poppy. All rights reserved.
//

import AVFoundation

var player = AVAudioPlayer()
var quePlayer = AVQueuePlayer()
var counter = 0

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

func music(queue: [String]){
    var itemQue: [AVPlayerItem] = []
    
    for title in queue{
        guard let path = Bundle.main.path(forResource: title, ofType: "m4a") else {return}
        let item = AVPlayerItem(url: URL(fileURLWithPath: path))
        itemQue.append(item)
    }
   
    quePlayer = AVQueuePlayer(items: itemQue)
    quePlayer.play()
}
// Delegate method for AVAudioPlayerDelegate which is called every time when song finished.
//func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool){
//
//    if flag {
//        counter += 1
//    }
//
//    if ((counter + 1) == song.count) {
//        counter = 0
//    }
//
//    music()
//}
