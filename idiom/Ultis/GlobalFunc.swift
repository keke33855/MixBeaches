//
//  GlobalFunc.swift
//  nomura
//
//  Created by lio on 2019/6/13.
//  Copyright © 2019 lio. All rights reserved.
//

import UIKit

public func print(_ items: Any..., separator: String = " ", terminator: String = "\n") {
    #if DEBUG
    let output = items.map { "\($0)" }.joined(separator: separator)
    Swift.print(output, terminator: terminator)
    #endif
}

public func delay(_ timeInterval: TimeInterval = 0.3, execute: @escaping (() -> Void)) {
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + timeInterval, execute: execute)
}

public func openURL(_ url: URL) {
    guard UIApplication.shared.canOpenURL(url) else { return }
    GCD.main {
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
}
