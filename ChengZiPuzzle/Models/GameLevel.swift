//
//  GameLevel.swift
//  ChengZiPuzzle
//
//  Created by jf on 11/11/19.
//  Copyright © 2019 chang. All rights reserved.
//

import Foundation

enum GameLevel: Int {
    case level1
    case level2
    case level3
    
    static func defaultInstance() -> GameLevel {
        return .level1
    }
    
    var title: String {
        switch self {
        case .level1:
            return "3 x 3"
        case .level2:
            return "4 x 4"
        case .level3:
            return "5 x 5"
        }
    }
    
    var numOfRow: Int {
        switch self {
        case .level1:
            return 3
        case .level2:
            return 4
        case .level3:
            return 5
        }
    }
    
    var countDownTime: TimeInterval {
        switch self {
        case .level1:
            return 5 //5 * 60
        case .level2:
            return 7 * 60
        case .level3:
            return 9 * 60
        }
    }
}
