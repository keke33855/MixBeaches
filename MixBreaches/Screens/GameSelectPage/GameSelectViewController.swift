//
//  GameSelectViewController.swift
//  ChengZiPuzzle
//
//  Created by jf on 11/10/19.
//  Copyright © 2019 chang. All rights reserved.
//

import UIKit

class GameSelectViewController: BaseViewController {

    @IBOutlet private weak var bestScoreLbl: UILabel!
    
    static func instance() -> GameSelectViewController {
        let vc = GameSelectViewController.initFromStoryboard()
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let bestScore = UserDefaults.StringManager.string(forKey: .bestScore) ?? "NoRecord"
        bestScoreLbl.isHidden = bestScore == "NoRecord"
        bestScoreLbl.text = "BestScores:" + bestScore
    }

    // MARK: - Actions
    @IBAction func backTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
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
