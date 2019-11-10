//
//  UserDefault+Addtions.swift
//  nomura
//
//  Created by wanglei on 2019/7/1.
//  Copyright © 2019 lio. All rights reserved.
//

import Foundation

extension UserDefaults {
    struct FlagManager: BoolUserDefaultable {

        private init() {}

        enum BoolDefaultKey: String {
            case isSupportMultipleCardSets
            
            func toggle() {
                var boolValue = UserDefaults.FlagManager.bool(forKey: self)
                boolValue.toggle()
                UserDefaults.FlagManager.set(boolValue, forKey: self)
            }
        }
    }

    struct StringManager: StringUserDefaultable {

        private init() {}

        enum StringDefaultKey: String {
            case expires
        }
    }
}
