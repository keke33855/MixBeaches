//
//  Keychain.swift
//  nomura
//
//  Created by lio on 2019/7/29.
//  Copyright © 2019 lio. All rights reserved.
//

import Foundation

final class Keychain {
    enum KeychainError: Error {
        case unhandled(status: OSStatus)
        case unexpectedItemData
    }

    final class Configuration {
        var service: String = (Bundle.main.infoDictionary?[kCFBundleIdentifierKey as String] as? String) ?? "Keychain.Configuration.Service"
        var accessGroup: String?
    }

    let configuration = Configuration()

    @discardableResult
    func config(configure: ((Configuration) -> Void)? = nil) -> Self {
        configure?(configuration)
        return self
    }

    @discardableResult
    func set(forKey key: String, data: Data) -> Bool {
        delete(forKey: key)
        var query = Keychain.defaultQuery(configuration: configuration, account: key)
        query[kSecValueData as String] = data as AnyObject

        let status = SecItemAdd(query as CFDictionary, nil)
        return status == noErr
    }

    @discardableResult
    func get(forKey key: String) -> Result<Data, KeychainError> {
        var query = Keychain.defaultQuery(configuration: configuration, account: key)
        query[kSecMatchLimit as String] = kSecMatchLimitOne
        query[kSecReturnAttributes as String] = kCFBooleanTrue
        query[kSecReturnData as String] = kCFBooleanTrue

        var queryResult: AnyObject?
        let status = withUnsafeMutablePointer(to: &queryResult) {
            SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0))
        }

        guard status == noErr else { return .failure(.unhandled(status: status)) }
        guard let existingItem = queryResult as? [String: AnyObject],
            let data = existingItem[kSecValueData as String] as? Data else {
                return .failure(.unexpectedItemData)
        }
        return .success(data)
    }

    @discardableResult
    func delete(forKey key: String) -> Bool {
        let query = Keychain.defaultQuery(configuration: configuration, account: key)
        let status = SecItemDelete(query as CFDictionary)
        return status == noErr || status == errSecItemNotFound
    }

    private static func defaultQuery(configuration: Configuration, account: String? = nil) -> [String: AnyObject] {
        var query = [String: AnyObject]()
        query[kSecClass as String] = kSecClassGenericPassword
        query[kSecAttrService as String] = configuration.service as AnyObject
        if let account = account {
            query[kSecAttrAccount as String] = account as AnyObject
        }
        if let accessGroup = configuration.accessGroup {
            query[kSecAttrAccessGroup as String] = accessGroup as AnyObject
        }
        return query
    }
}

extension Keychain {
    func get(forKey key: String) -> String? {
        let result: Result<Data, KeychainError> = get(forKey: key)
        switch result {
        case .success(let data):
            return String(data: data, encoding: .utf8)
        case .failure:
            return nil
        }
    }

    func set(forKey key: String, value: String) -> Bool {
        guard let data = value.data(using: .utf8) else { return false }
        return set(forKey: key, data: data)
    }
}
