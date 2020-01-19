//
//  LaunchViewController.swift
//  JiPaiQi
//
//  Created by jf on 2019/9/5.
//  Copyright © 2019 lixi. All rights reserved.
//

import UIKit

class LaunchViewController: BaseViewController {

    enum NavigationType {
        case top
        case errorHint(String)
        case newVersionHint
    }
    
    static func instance() -> LaunchViewController {
        let vc = LaunchViewController()
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        showTopPage()
    }
    
    private func showTopPage() {
        let homePage = HomeViewController.instance()
        let idiomNav = UINavigationController(rootViewController: homePage)
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.window?.rootViewController = idiomNav
        }
    }
}
