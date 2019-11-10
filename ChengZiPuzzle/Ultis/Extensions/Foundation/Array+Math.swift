//
//  Array+Math.swift
//  nomura
//
//  Created by lio on 2019/7/6.
//  Copyright © 2019 lio. All rights reserved.
//

import Foundation

extension Array where Element == Double {
    var sum: Double {
        return reduce(0, +)
    }

    var average: Double {
        return isEmpty ? 0 : sum / Double(count)
    }
}
