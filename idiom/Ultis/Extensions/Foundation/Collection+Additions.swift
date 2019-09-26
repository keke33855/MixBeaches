//
//  Collection+Additions.swift
//  nomura
//
//  Created by lio on 2019/6/30.
//  Copyright © 2019 lio. All rights reserved.
//

import Foundation

extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
