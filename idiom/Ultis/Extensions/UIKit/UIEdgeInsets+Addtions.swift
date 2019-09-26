//
//  UIEdgeInsets+Addtions.swift
//  nomura
//
//  Created by wanglei on 2019/7/9.
//  Copyright © 2019 lio. All rights reserved.
//

import UIKit

extension UIEdgeInsets {
    static var hideSeperatorInsets: UIEdgeInsets {
        return .init(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width + 1)
    }
}
