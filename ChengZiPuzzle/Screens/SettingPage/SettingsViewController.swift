//
//  SettingsViewController.swift
//  ChengZiPuzzle
//
//  Created by jf on 11/13/19.
//  Copyright © 2019 chang. All rights reserved.
//

import UIKit

class SettingsViewController: BaseViewController {
    
    @IBOutlet weak var centerYContriant: NSLayoutConstraint!
    @IBOutlet private weak var gameMusicCheckBtn: UIButton!
    @IBOutlet private weak var gameSoundCheckBtn: UIButton!
    
    static func instance() -> SettingsViewController {
        return SettingsViewController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindAction()
    }
    
    private func bindAction() {
        gameMusicCheckBtn.adjustsImageWhenHighlighted = false
        gameSoundCheckBtn.adjustsImageWhenHighlighted = false
        
        let gameMusicImage = UserDefaults.FlagManager.bool(forKey: .isBackgroundSoundOff) ? #imageLiteral(resourceName: "unchecked") : #imageLiteral(resourceName: "checked")
        gameMusicCheckBtn.setBackgroundImage(gameMusicImage, for: .normal)
        
        let gameSoundImage = UserDefaults.FlagManager.bool(forKey: .isPlaySoundOff) ? #imageLiteral(resourceName: "unchecked") : #imageLiteral(resourceName: "checked")
        gameSoundCheckBtn.setBackgroundImage(gameSoundImage, for: .normal)
        
        gameMusicCheckBtn.rx.tap
            .subscribe({ [weak self] _ in
                UserDefaults.FlagManager.BoolDefaultKey.isBackgroundSoundOff.toggle()
                let isBackgroundMusicOff = UserDefaults.FlagManager.bool(forKey: .isBackgroundSoundOff)
                let gameMusicImage = !isBackgroundMusicOff ? #imageLiteral(resourceName: "checked") : #imageLiteral(resourceName: "unchecked")
                self?.gameMusicCheckBtn.setBackgroundImage(gameMusicImage, for: .normal)
                !isBackgroundMusicOff ? AppMusicPlayer.shared.play(force: true) : AppMusicPlayer.shared.stop()
            })
            .disposed(by: disposeBag)
        
        gameSoundCheckBtn.rx.tap
            .subscribe({ [weak self] _ in
                UserDefaults.FlagManager.BoolDefaultKey.isPlaySoundOff.toggle()
                let gameSoundImage = !UserDefaults.FlagManager.bool(forKey: .isPlaySoundOff) ? #imageLiteral(resourceName: "checked") : #imageLiteral(resourceName: "unchecked")
                self?.gameSoundCheckBtn.setBackgroundImage(gameSoundImage, for: .normal)
            })
            .disposed(by: disposeBag)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        centerYContriant.constant = 0
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       options: [.curveEaseInOut],
                       animations: { [weak self] in
                        self?.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
                        self?.view.layoutIfNeeded()
            },
                       completion: nil)
    }
    
    func show() {
        let gameLevelPage = SettingsViewController.instance()
        gameLevelPage.modalPresentationStyle = .overCurrentContext
        gameLevelPage.view.backgroundColor = .clear
        UIApplication.topViewController?.definesPresentationContext = true
        UIApplication.topViewController?.present(gameLevelPage, animated: false, completion: nil)
    }
    
    @IBAction func closeClicked(_ sender: Any) {
        centerYContriant.constant = Metric.centerWhenHide
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
    
    @IBAction func rateUsTapped(_ sender: Any) {
        (UIApplication.shared.delegate as? AppDelegate)?.appManager.showAppInStore()
    }
}

extension SettingsViewController {
    struct Metric {
        static let centerWhenShow: CGFloat = 0
        static let centerWhenHide: CGFloat = 1000
    }
}
