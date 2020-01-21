//
//  UserDefault+Puzzle.swift
//  ChengZiPuzzle
//
//  Created by jf on 12/25/19.
//  Copyright © 2019 chang. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    static func getStoredGameLevel() -> GameLevel {
        let levelValue = UserDefaults.Game.int(forKey: .gameLevel)
        return GameLevel(rawValue: levelValue) ?? .level1
    }
    
    struct Game: StringUserDefaultable, IntUserDefaultable, BoolUserDefaultable {
        private init() {}
        
        enum StringDefaultKey: String {
            case bestScore
        }
        
        enum IntDefaultKey: String {
            case gameLevel
        }
        
        enum BoolDefaultKey: String {
            case isBackgroundSoundOff
            case isPlaySoundOff
            
            func toggle() {
                var boolValue = UserDefaults.Game.bool(forKey: self)
                boolValue.toggle()
                UserDefaults.Game.set(boolValue, forKey: self)
            }
        }
    }
}

