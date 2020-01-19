//
//  HomeViewController.swift
//  idiom
//
//  Created by jf on 2019/9/25.
//  Copyright © 2019 chang. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    
    // MARK: - life cycle
    static func instance() -> HomeViewController {
        let vc = HomeViewController()
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.oc_checkVersion(appID: "1492618171")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        AppMusicPlayer.shared.play(force: false)
    }

    // MARK: - functional
    @IBAction func playGame(_ sender: Any) {
        let gameSelectPage = GameSelectViewController.instance()
        navigationController?.pushViewController(gameSelectPage, animated: true)
    }
}
