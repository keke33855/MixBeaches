//
//  UIScreen+Additions.swift
//  nomura
//
//  Created by lio on 2019/6/22.
//  Copyright © 2019 lio. All rights reserved.
//

import UIKit.UIScreen

extension UIScreen {
    static var width: CGFloat {
        return size.width
    }

    static var height: CGFloat {
        return size.height
    }

    static var size: CGSize {
        return UIScreen.main.bounds.size
    }
}
