//
//  Array+windowed.swift
//  nomura
//
//  Created by lio on 2019/7/6.
//  Copyright © 2019 lio. All rights reserved.
//

import Foundation

extension Array {
    // https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/windowed.html
    func windowed(size: Int, step: Int = 1, partialWindows: Bool = false) -> [[Element]] {
        var index = 0
        var results: [[Element]] = []
        while index < count {
            let windowedSize = Swift.min(size, count - index)
            if windowedSize < size && !partialWindows {
                break
            }
            results.append(Array(self[index..<(index + windowedSize)]))
            index += step
        }
        return results
    }

    func chunked(size: Int, partialWindows: Bool = false) -> [[Element]] {
        return self.windowed(size: size, step: size, partialWindows: partialWindows)
    }
}
