//
//  AppManager.swift
//  nomura
//
//  Created by lio on 2019/6/14.
//  Copyright © 2019 lio. All rights reserved.
//

import UIKit

extension Keychain {
    enum Key: String {
        case uuid
        case token
    }

    @discardableResult
    func get(forKey key: Key) -> String? {
        return self.get(forKey: key.rawValue)
    }

    @discardableResult
    func set(forKey key: Key, value: String) -> Bool {
        return self.set(forKey: key.rawValue, value: value)
    }

    @discardableResult
    func delete(forKey key: Key) -> Bool {
        return self.delete(forKey: key.rawValue)
    }
}

final class AppManager {

    let api = APIs()
    let keychain = Keychain()

    private(set) var indexColorReverse: Bool = false

    init() {}
}

extension AppManager {
    private func setupBars() {
        // NavigationBar
        let navigationBar = UINavigationBar.appearance()
        navigationBar.tintColor = App.Colors.Navigation.barTint

        // Tabbar
        let globalTabbar = UITabBar.appearance()
        globalTabbar.barTintColor = App.Colors.Tabbar.background
        globalTabbar.isTranslucent = false
        globalTabbar.tintColor = App.Colors.Tabbar.tint
    }
    
    func showAppInStore() {
        let targetUrl = "itms-apps://itunes.apple.com/app/id\(Const.appID)"
        if let url = URL(string: targetUrl),
            UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    func dealWithAdvertisementTap(actionUrl: String) {
        guard actionUrl.isValidUrl,
            let url = URL(string: actionUrl) else {
            return
        }

        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}

extension AppManager {
    var uuid: String {
        if let uuid = keychain.get(forKey: .uuid) {
            return uuid
        }
        let newUUID = UUID().uuidString
        keychain.set(forKey: .uuid, value: newUUID)
        return newUUID
    }
}
