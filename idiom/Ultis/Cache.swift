//
//  Cache.swift
//  nomura
//
//  Created by liofty on 2019/7/23.
//  Copyright © 2019 lio. All rights reserved.
//

import Foundation

final class Cache<Key: Hashable, Value> {
    private let cache = NSCache<AnyObject, AnyObject>()

    func set(key: Key, value: Value) {
        cache.setObject(value as AnyObject, forKey: key as AnyObject)
    }

    func object(key: Key) -> Value? {
        return cache.object(forKey: key as AnyObject) as? Value
    }

    func clear() {
        cache.removeAllObjects()
    }
}
