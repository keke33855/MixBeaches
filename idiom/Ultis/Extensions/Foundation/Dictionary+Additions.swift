//
//  Dictionary+Additions.swift
//  nomura
//
//  Created by liofty on 2019/6/17.
//  Copyright © 2019 lio. All rights reserved.
//

import Foundation

extension Dictionary {
    mutating func append(dict: Dictionary) {
        dict.forEach { key, value in
            self.updateValue(value, forKey: key)
        }
    }
}
