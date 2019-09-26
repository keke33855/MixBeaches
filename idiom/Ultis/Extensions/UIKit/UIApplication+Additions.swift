//
//  UIApplication+Additions.swift
//  nomura
//
//  Created by lio on 2019/6/13.
//  Copyright © 2019 lio. All rights reserved.
//

import UIKit

extension UIApplication {
    static var topViewController: UIViewController? {
        return _topViewController(UIApplication.shared.keyWindow?.rootViewController)
    }

    static var topViewControllerNoAlert: UIViewController? {
        return _topViewController(UIApplication.shared.keyWindow?.rootViewController,
                                  ignoreAlert: true)
    }

    private static func _topViewController(_ controller: UIViewController?,
                                           ignoreAlert: Bool = false) -> UIViewController? {
        if let navController = controller as? UINavigationController {
            return _topViewController(navController.visibleViewController)
        }

        if let tabbarController = controller as? UITabBarController {
            return _topViewController(tabbarController.selectedViewController)
        }

        if let childController = controller?.children.last {
            return _topViewController(childController)
        }

        if let presentedController = controller?.presentedViewController {
            if presentedController.isKind(of: UIAlertController.self), !ignoreAlert {
                return _topViewController(presentedController)
            }
        }

        return controller
    }
}
