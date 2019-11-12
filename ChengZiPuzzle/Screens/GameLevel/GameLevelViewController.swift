//
//  GameLevelViewController.swift
//  ChengZiPuzzle
//
//  Created by jf on 11/12/19.
//  Copyright © 2019 chang. All rights reserved.
//

import UIKit
import RxSwift

class GameLevelViewController: BaseViewController {

    var gameLevel: GameLevel = UserDefaults.getStoredGameLevel() {
        didSet {
            UserDefaults.IntValueManager.set(gameLevel.rawValue, forKey: .gameLevel)
            let level1Image = gameLevel == .level1 ? #imageLiteral(resourceName: "checked") : #imageLiteral(resourceName: "unchecked")
            level1Btn.setBackgroundImage(level1Image, for: .normal)
            let level2Image = gameLevel == .level2 ? #imageLiteral(resourceName: "checked") : #imageLiteral(resourceName: "unchecked")
            level2Btn.setBackgroundImage(level2Image, for: .normal)
            let level3Image = gameLevel == .level3 ? #imageLiteral(resourceName: "checked") : #imageLiteral(resourceName: "unchecked")
            level3Btn.setBackgroundImage(level3Image, for: .normal)
        }
    }
    
    @IBOutlet weak var boardViewCenterYConstraint: NSLayoutConstraint!
    @IBOutlet private weak var level1Btn: UIButton!
    @IBOutlet private weak var level2Btn: UIButton!
    @IBOutlet private weak var level3Btn: UIButton!
    
    static func instance() -> GameLevelViewController {
        return GameLevelViewController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bindAction()
    }
    
    private func bindAction() {
        gameLevel = UserDefaults.getStoredGameLevel()
        level1Btn.adjustsImageWhenHighlighted = false
        level2Btn.adjustsImageWhenHighlighted = false
        level3Btn.adjustsImageWhenHighlighted = false
        
        let level1Tap = level1Btn.rx.tap.map { GameLevel.level1 }
        let level2Tap = level2Btn.rx.tap.map { GameLevel.level2 }
        let level3Tap = level3Btn.rx.tap.map { GameLevel.level3 }
        
        Observable.from([level1Tap, level2Tap, level3Tap])
            .merge()
            .subscribe(onNext: { [weak self] (gameLevel) in
                self?.gameLevel = gameLevel
            })
            .disposed(by: disposeBag)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        boardViewCenterYConstraint.constant = 0
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       options: [.curveEaseInOut],
                       animations: { [weak self] in
                        self?.view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
                        self?.view.layoutIfNeeded()
        },
                       completion: nil)
    }
    
    func show() {
        let gameLevelPage = GameLevelViewController.instance()
        gameLevelPage.modalPresentationStyle = .overCurrentContext
        gameLevelPage.view.backgroundColor = .clear
        UIApplication.topViewController?.definesPresentationContext = true
        UIApplication.topViewController?.present(gameLevelPage, animated: false, completion: nil)
    }
    
    @IBAction func closeTapped(_ sender: Any) {
        boardViewCenterYConstraint.constant = Metric.centerWhenHide
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       options: [.curveEaseOut],
                       animations: { [weak self] in
                        self?.view.backgroundColor = UIColor.black.withAlphaComponent(0)
                        self?.view.layoutIfNeeded()
            },
                       completion: { [weak self] _ in
                        self?.dismiss(animated: false, completion: nil)
        })
    }
}

extension GameLevelViewController {
    struct Metric {
        static let centerWhenShow: CGFloat = 0
        static let centerWhenHide: CGFloat = 1000
    }
}
