//
//  WriteIdiomViewController.swift
//  idiom
//
//  Created by jf on 2019/9/25.
//  Copyright © 2019 chang. All rights reserved.
//

import UIKit

class WriteIdiomViewController: BaseViewController {

    @IBOutlet private weak var resultTextfield: UITextField!
    @IBOutlet private weak var firstLbl: UILabel!
    @IBOutlet private weak var secondLbl: UILabel!
    @IBOutlet private weak var thirdLbl: UILabel!
    @IBOutlet private weak var fourthLbl: UILabel!
    
    private var idiomList = NSArray()
    private var currentIndex = 0
    private var randomIndex = 0
    
    // MARK: - life cycle
    static func instance() -> WriteIdiomViewController {
        return WriteIdiomViewController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupData()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateCurrentQuestion()
    }
    
    // MARK: - setup
    func setupView() {
        
    }
    
    func setupData() {
        guard let plistPath = Bundle.main.path(forResource: Metric.dataPlistFile,
                                            ofType: "plist"),
            let idiomArray = NSArray(contentsOfFile: plistPath),
            idiomArray.count > 0 else {
                                                self.showError("资源加载失败")
                                                return
        }
        idiomList = idiomArray
    }
    
    private func showError(_ message: String) {
        
        GCD.after(sec: 1) { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
    
    // MARK: - action
    @IBAction func backBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func hintBtnTapped(_ sender: Any) {
        if let hintLabel = view.viewWithTag(randomIndex) as? UILabel {
            resultTextfield.text = hintLabel.text
        }
    }
    
    @IBAction func previousBtnTapped(_ sender: Any) {
        nextQuestion()
    }
    
    @IBAction func nextBtnTapped(_ sender: Any) {
        nextQuestion()
    }
    
    @IBAction func confirmBtnTapped(_ sender: Any) {
        if let hideLabel = self.view.viewWithTag(randomIndex) as? UILabel {
            if(resultTextfield.text == hideLabel.text){
                print("答对了")
                WSProgressHUD.showShimmeringString("答对了，下面来学习这个成语吧！")
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    WSProgressHUD.dismiss()
                }
                let currentIdiom = idiomList[currentIndex] as! String
                let extendItem = IdiomDescViewController()
                extendItem.idiomString = currentIdiom
                self.navigationController?.pushViewController(extendItem, animated: true)
            } else {
                print("答错了")
                WSProgressHUD.showShimmeringString("答错了～")
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    WSProgressHUD.dismiss()
                }
            }
        }
    }

    private func nextQuestion() {
        if(currentIndex < idiomList.count - 1){
            currentIndex += 1
            updateCurrentQuestion()
        }
    }
    
    private func updateCurrentQuestion() {
        resultTextfield.text = ""
        let currentIdiom = idiomList[currentIndex] as! String
        let currentIdiomstring = currentIdiom as NSString
        firstLbl.text = currentIdiomstring.substring(with: NSRange(location: 0, length: 1))
        secondLbl.text = currentIdiomstring.substring(with: NSRange(location: 1, length: 1))
        thirdLbl.text = currentIdiomstring.substring(with: NSRange(location: 2, length: 1))
        fourthLbl.text = currentIdiomstring.substring(with: NSRange(location: 3, length: 1))
        
        randomIndex = Int(arc4random() % 4) + 1
        if let hideLabel = self.view.viewWithTag(randomIndex) as? UILabel {
            resultTextfield.frame = CGRect(origin: .zero,
                                           size: CGSize(width: hideLabel.bounds.width + 8,
                                                        height: hideLabel.bounds.height + 8))
            resultTextfield.center = hideLabel.center
            view.layoutIfNeeded()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        resultTextfield.endEditing(true)
    }
}

extension WriteIdiomViewController {
    struct Metric {
        static let dataPlistFile = "idoimlist"
    }
}
