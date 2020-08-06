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
                player.play()

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
        
        if quePlayer.currentItem == item{
            
        }
    }
    
    quePlayer = AVQueuePlayer(items: itemQue)
    quePlayer.play()
    
    
}

func checkIndex(queue: [String]) -> Int{
    for i in 0..<queue.count{
        guard let path = Bundle.main.path(forResource: queue[i], ofType: "m4a") else {return 0}
        let item = AVPlayerItem(url: URL(fileURLWithPath: path))
        //itemQue.append(item)
        
        if quePlayer.currentItem == item{
            return i
        }
    }
    return 0
}
