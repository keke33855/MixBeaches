//
//  AppMusicPlayer.swift
//  ChengZiPuzzle
//
//  Created by jf on 11/13/19.
//  Copyright © 2019 chang. All rights reserved.
//

import Foundation
import AVKit

class AppMusicPlayer {
    
    static let shared = AppMusicPlayer()
    private init() {}
    
    let appBgPlayer: AVAudioPlayer? = {
        return GameViewController.createAudioPlayer(name: "Mining by Moonlight", type: "mp3")
    }()

    
    func playIfCan() {
        if UserDefaults.FlagManager.bool(forKey: .isBackgroundSoundOn) {
            appBgPlayer?.play()
        }
    }
    
    func stop() {
        appBgPlayer?.pause()
    }
}
