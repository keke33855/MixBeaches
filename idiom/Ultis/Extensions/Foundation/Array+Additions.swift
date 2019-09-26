//
//  Array+Additions.swift
//  nomura
//
//  Created by lio on 2019/6/13.
//  Copyright © 2019 lio. All rights reserved.
//

import Foundation

extension Sequence {
    func group<U: Hashable>(key: (Iterator.Element) -> U) -> [U: [Iterator.Element]] {
        var results: [U: [Iterator.Element]] = [:]
        for element in self {
            let key = key(element)
            if case nil = results[key]?.append(element) {
                results[key] = [element]
            }
        }
        return results
    }
}

extension Array {
    func safeElement(_ i: Int) -> Array.Iterator.Element? {
        guard !isEmpty && self.count > i else { return nil }
        let event = self.enumerated().first { $0.offset == i }
        return event?.element
    }
}
