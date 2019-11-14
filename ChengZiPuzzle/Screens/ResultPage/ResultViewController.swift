//
//  ResultViewController.swift
//  ChengZiPuzzle
//
//  Created by jf on 11/14/19.
//  Copyright © 2019 chang. All rights reserved.
//

import UIKit

class ResultViewController: BaseViewController {
    
    enum ResultDismissType {
        case replay
        case returnHome
    }
    
    @IBOutlet private weak var currentScoreLbl: UILabel!
    @IBOutlet private weak var bestScoreLbl: UILabel!
    @IBOutlet private weak var replayBtn: UIButton!
    @IBOutlet private weak var closeBtn: UIButton!
    @IBOutlet private weak var titleLbl: UILabel!
    
    @IBOutlet weak var boardCenterYConstraint: NSLayoutConstraint!
    
    var completion: ((ResultDismissType) -> Void)?
    
    var gameResult: GameResult = .fail
    
    static func instance(gameResult: GameResult, completion: @escaping (ResultDismissType) -> Void) -> ResultViewController {
        let vc = ResultViewController()
        vc.gameResult = gameResult
        vc.completion = completion
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configScoreView()
        bindAction()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        boardCenterYConstraint.constant = 0
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       options: [.curveEaseInOut],
                       animations: { [weak self] in
                        self?.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
                        self?.view.layoutIfNeeded()
            },
                       completion: nil)
    }
    
    private func configScoreView() {
        titleLbl.text = gameResult.title
        var bestScore = "NoRecord"
        if let score = UserDefaults.StringManager.string(forKey: .bestScore) {
            bestScore = score
        }
        bestScoreLbl.text = bestScore
        
        var currentScore = "00:00:00"
        if case GameResult.win(let score) = gameResult {
            currentScore = score
        }
        currentScoreLbl.text = currentScore
        
        if bestScore == "NoRecord" || currentScore > bestScore {
            UserDefaults.StringManager.set(currentScore, forKey: .bestScore)
        }
    }

    static func show(gameResult: GameResult, completion: @escaping (ResultDismissType) -> Void) {
        let resultPage = ResultViewController.instance(gameResult: gameResult, completion: completion)
        resultPage.modalPresentationStyle = .overCurrentContext
        resultPage.view.backgroundColor = .clear
        UIApplication.topViewController?.definesPresentationContext = true
        UIApplication.topViewController?.present(resultPage, animated: false, completion: nil)
    }
    
    func bindAction() {
        closeBtn.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.hide(type: .returnHome)
            })
            .disposed(by: disposeBag)
        
        replayBtn.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.hide(type: .replay)
            })
            .disposed(by: disposeBag)
    }

    private func hide(type: ResultDismissType) {
        boardCenterYConstraint.constant = Metric.centerWhenHide
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       options: [.curveEaseOut],
                       animations: { [weak self] in
                        self?.view.backgroundColor = UIColor.black.withAlphaComponent(0)
                        self?.view.layoutIfNeeded()
            },
                       completion: { [weak self] _ in
                        self?.completion?(type)
                        self?.dismiss(animated: true, completion: {
                            
                        })
        })
    }
}

extension ResultViewController {
    struct Metric {
        static let centerWhenShow: CGFloat = 0
        static let centerWhenHide: CGFloat = 1000
    }
}
