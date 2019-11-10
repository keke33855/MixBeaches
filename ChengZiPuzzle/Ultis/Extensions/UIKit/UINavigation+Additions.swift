//
//  UINavigation+Additions.swift
//  nomura
//
//  Created by liofty on 2019/6/25.
//  Copyright © 2019 lio. All rights reserved.
//

import UIKit

extension UINavigationItem {
    func setBackButtonTitle(_ title: String = "戻る") {
        self.backBarButtonItem = UIBarButtonItem(title: title, style: .plain, target: nil, action: nil)
    }
}
