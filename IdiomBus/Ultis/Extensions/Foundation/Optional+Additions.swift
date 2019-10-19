//
//  Optional+Additions.swift
//  nomura
//
//  Created by lio on 2019/6/30.
//  Copyright © 2019 lio. All rights reserved.
//

import Foundation

public extension Optional {
    func unwrapped(or defaultValue: Wrapped) -> Wrapped {
        return self ?? defaultValue
    }

    func unwrapped(or error: Error) throws -> Wrapped {
        guard let wrapped = self else { throw error }
        return wrapped
    }

    static func ??= (lhs: inout Optional, rhs: Optional) {
        guard let rhs = rhs else { return }
        lhs = rhs
    }

    static func ?= (lhs: inout Optional, rhs: @autoclosure () -> Optional) {
        if lhs == nil {
            lhs = rhs()
        }
    }
}

public extension Optional where Wrapped == String {
    var orEmpty: Wrapped {
        return self.unwrapped(or: "")
    }

    func appending(_ appending: Wrapped, defaultVal: Wrapped = "") -> Wrapped {
        if case let .some(val) = self {
            return val + appending
        }
        return defaultVal
    }
}

infix operator ??=: AssignmentPrecedence
infix operator ?=: AssignmentPrecedence
