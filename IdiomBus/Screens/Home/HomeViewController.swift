//
//  HomeViewController.swift
//  idiom
//
//  Created by jf on 2019/9/25.
//  Copyright © 2019 chang. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    
    @IBOutlet weak var writeBtn: UIButton!
    @IBOutlet weak var searchIdiomBtn: UIButton!
    @IBOutlet weak var favoriteBtn: UIButton!
    
    // MARK: - life cycle
    static func instance() -> HomeViewController {
        let vc = HomeViewController()
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bindAction()
    }

    // MARK: - functional
    private func bindAction() {
        writeBtn.rx.tap
            .asDriver()
            .debounce(0.1)
            .drive(onNext: {
                let idiomVC = WriteIdiomViewController.instance()
                self.navigationController?.pushViewController(idiomVC, animated: true)
            })
            .disposed(by: disposeBag)
        
        searchIdiomBtn.rx.tap
            .asDriver()
            .debounce(0.1)
            .drive(onNext: {
                let idiomVC = IdiomSearchViewController()
                self.navigationController?.pushViewController(idiomVC, animated: true)
            })
            .disposed(by: disposeBag)
        
        favoriteBtn.rx.tap
            .asDriver()
            .debounce(0.1)
            .drive(onNext: {
                let idiomVC = FavoriteViewController()
                self.navigationController?.pushViewController(idiomVC, animated: true)
            })
            .disposed(by: disposeBag)
    }

}
