//
//  IdiomHomeViewController.swift
//  idiom
//
//  Created by chang on 2022/8/22.
//  Copyright © 2019 chang. All rights reserved.
//

import UIKit

class IdiomHomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.title = "成语沙龙"
        self.view.backgroundColor = UIColor.white
        let bcakImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: screen_w , height: screen_H))
        bcakImageView.image = UIImage(named: "idiomBack")
        self.view.addSubview(bcakImageView)
        // Do any additional setup after loading the view.
        let base_y = (screen_H - 300)/2
        let inputWordButton = UIButton(frame: CGRect(x: (screen_w - 190)/2, y: base_y, width: 190, height: 70))
//        inputWordButton.backgroundColor = UIColor.gray
        inputWordButton.titleLabel?.font = UIFont.systemFont(ofSize: 40)
        inputWordButton.setTitle("成语填词", for: .normal)
        self.view.addSubview(inputWordButton)
        inputWordButton.addTarget(self, action: #selector(inputAction), for: .touchUpInside)
        
        let idiomSearchButton = UIButton(frame: CGRect(x: (screen_w - 190)/2, y: base_y + 30 + 70, width: 190, height: 70))
//        idiomSearchButton.backgroundColor = UIColor.gray
        idiomSearchButton.titleLabel?.font = UIFont.systemFont(ofSize: 40)
        idiomSearchButton.setTitle("成语搜索", for: .normal)
        self.view.addSubview(idiomSearchButton)
        idiomSearchButton.addTarget(self, action: #selector(searchAction), for: .touchUpInside)
        
        let myIdiomButton = UIButton(frame: CGRect(x: (screen_w - 190)/2, y: base_y + 30 + 70 + 100, width: 190, height: 70))
//        myIdiomButton.backgroundColor = UIColor.gray
        myIdiomButton.titleLabel?.font = UIFont.systemFont(ofSize: 40)
        myIdiomButton.setTitle("我的收藏", for: .normal)
        self.view.addSubview(myIdiomButton)
        myIdiomButton.addTarget(self, action: #selector(myIdiomAction), for: .touchUpInside)
        
        inputWordButton.setBackgroundImage(UIImage(named: "btnBack"), for: .normal)
        idiomSearchButton.setBackgroundImage(UIImage(named: "btnBack"), for: .normal)
        myIdiomButton.setBackgroundImage(UIImage(named: "btnBack"), for: .normal)
        inputWordButton.setTitleColor(UIColor.black, for: .normal)
        idiomSearchButton.setTitleColor(UIColor.black, for: .normal)
        myIdiomButton.setTitleColor(UIColor.black, for: .normal)
    }
    @objc func inputAction(){
        let idiomVC = ViewController()
        self.navigationController?.pushViewController(idiomVC, animated: true)
    }
    @objc func searchAction(){
        let idiomVC = IdiomSearchViewController()
        self.navigationController?.pushViewController(idiomVC, animated: true)
    }
    @objc func myIdiomAction(){
        let idiomVC = StarViewController()
        self.navigationController?.pushViewController(idiomVC, animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
