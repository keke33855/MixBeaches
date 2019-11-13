//
//  GameSelectViewController.swift
//  ChengZiPuzzle
//
//  Created by jf on 11/10/19.
//  Copyright © 2019 chang. All rights reserved.
//

import UIKit

class GameSelectViewController: BaseViewController {

    static func instance() -> GameSelectViewController {
        let vc = GameSelectViewController.initFromStoryboard()
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    // MARK: - Actions
    @IBAction func backTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func highScoresTapped(_ sender: Any) {
        
    }
    
    @IBAction func puzzleGalleryTapped(_ sender: Any) {
        let puzzleSelectPage = GamePhotoSelectViewController.instance()
        navigationController?.pushViewController(puzzleSelectPage, animated: true)
    }
    
    @IBAction func gameLevelTapped(_ sender: Any) {
        let gameLevelPage = GameLevelViewController.instance()
        gameLevelPage.show()
    }
    
    @IBAction func settingTapped(_ sender: Any) {
        SettingsViewController.instance().show()
    }
}
