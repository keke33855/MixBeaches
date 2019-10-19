//
//  NSRecursiveLock+Additions.swift
//  nomura
//
//  Created by lio on 2019/6/13.
//  Copyright © 2019 lio. All rights reserved.
//

import Foundation

protocol Lock {
    func lock()
    func unlock()
}

extension NSRecursiveLock: Lock {
    @inline(__always)
    final func performLocked(_ action: () -> Void) {
        lock(); defer { unlock() }
        action()
    }

    @inline(__always)
    final func calculateLocked<T>(_ action: () -> T) -> T {
        lock(); defer { unlock() }
        return action()
    }

    @inline(__always)
    final func calculateLockedOrFail<T>(_ action: () throws -> T) throws -> T {
        lock(); defer { unlock() }
        let result = try action()
        return result
    }
}
