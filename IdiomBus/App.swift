//
//  App.swift
//  nomura
//
//  Created by lio on 2019/6/30.
//  Copyright © 2019 lio. All rights reserved.
//

import Foundation
import UIKit.UIColor

struct App {
    private init() {}

    struct Colors {

        enum Tabbar {
            static let background = UIColor(hex: 0x232429)
            static let tint = UIColor.white
        }

        enum Navigation {
            static let barTint = Tabbar.background
        }

        enum MenuBar {
            static let selectedBackgroud = UIColor(hex: 0xF5E126)
            static let normalBackgroud = UIColor.white
            static let selectedText = UIColor(hex: 0x232429)
            static let normalText = UIColor(hex: 0x7A8FA1)
        }

        enum Button {
            static let background = UIColor(hex: 0xF5E126)
            static let normalText = UIColor(hex: 0x232429)
        }

        enum BottomTab {
            static let background = UIColor(hex: 0x232429)
        }

        enum Other {
            static let hex7A8FA1 = UIColor(hex: 0x7A8FA1)
            static let hexF22B2B = UIColor(hex: 0xF22B2B)
            static let hexEBEBEB = UIColor(hex: 0xEBEBEB)
            static let whiteAlpha5 = UIColor.white.withAlphaComponent(0.5)
            static let hexF5E126 = UIColor(hex: 0xF5E126)
        }
    }

    struct Prefs: BoolUserDefaultable {
        enum BoolDefaultKey: String {
            case indexColorReverse
        }
    }
}
