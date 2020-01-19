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
        let player = GameViewController.createAudioPlayer(name: "Mining by Moonlight", type: "mp3")
        player?.numberOfLoops = -1
        return player
    }()

    
    func play(force: Bool) {
        if force || !UserDefaults.FlagManager.bool(forKey: .isBackgroundSoundOff) {
            appBgPlayer?.play()
        }
    }
    
    func stop() {
        appBgPlayer?.pause()
    }
}
