//
//  ViewController.swift
//  idiom
//
//  Created by chang on 2022/8/21.
//  Copyright © 2019 chang. All rights reserved.
//
let screen_w = UIScreen.main.bounds.size.width
let screen_H = UIScreen.main.bounds.size.height
import UIKit

class ViewController: UIViewController {

    var currentIndex = Int()
    var inputFiled = UITextField()
    var label1 = UILabel()
    var label2 = UILabel()
    var label3 = UILabel()
    var label4 = UILabel()
    
    var idiomArray = NSArray()
    var randomNumber = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        self.navigationItem.title = "成语填词"
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        self.view.backgroundColor = UIColor.white
        let bcakImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: screen_w , height: screen_H))
        bcakImageView.image = UIImage(named: "idiomBack")
        self.view.addSubview(bcakImageView)
        currentIndex = 0
        let diaryList:String = Bundle.main.path(forResource: "idoimlist", ofType:"plist")!
        
        idiomArray = NSArray(contentsOfFile:diaryList)!
       
        let currentIdiom = idiomArray[currentIndex] as! String
        
        let label_x = (screen_w - 160)/2
         label1 = UILabel(frame: CGRect(x: label_x, y: 200, width: 40, height: 30))
        label1.textAlignment = .center
        label1.font = UIFont.systemFont(ofSize: 28)
        label1.textColor = UIColor.black
        label1.tag = 1;
        self.view.addSubview(label1)
        
        label2 = UILabel(frame: CGRect(x: label_x + 40, y: 200, width: 40, height: 30))
        label2.textAlignment = .center
        label2.font = UIFont.systemFont(ofSize: 28)
        label2.textColor = UIColor.black
        label2.tag = 2;
        self.view.addSubview(label2)
        
         label3 = UILabel(frame: CGRect(x: label_x + 40 + 40, y: 200, width: 40, height: 30))
        label3.textAlignment = .center
        label3.font = UIFont.systemFont(ofSize: 28)
        label3.textColor = UIColor.black
        label3.tag = 3;
        self.view.addSubview(label3)
        
         label4 = UILabel(frame: CGRect(x: label_x + 40 + 40 + 40, y: 200, width: 40, height: 30))
        label4.textAlignment = .center
        label4.font = UIFont.systemFont(ofSize: 28)
        label4.textColor = UIColor.black
        label4.tag = 4;
        self.view.addSubview(label4)
        
        let currentIdiomstring = currentIdiom as NSString
        label1.text = currentIdiomstring.substring(with: NSRange(location: 0, length: 1))
        label2.text = currentIdiomstring.substring(with: NSRange(location: 1, length: 1))
        label3.text = currentIdiomstring.substring(with: NSRange(location: 2, length: 1))
        label4.text = currentIdiomstring.substring(with: NSRange(location: 3, length: 1))
        
         randomNumber = Int(arc4random() % 4) + 1
        
        let hideLabel = self.view.viewWithTag(randomNumber) as! UILabel
        
        inputFiled = UITextField(frame: CGRect(x: hideLabel.frame.origin.x , y: 195, width: 40, height: 40))
        inputFiled.backgroundColor = UIColor.white
        inputFiled.layer.borderWidth = 1
        inputFiled.layer.borderColor = UIColor.red.cgColor
        inputFiled.font = UIFont.systemFont(ofSize: 28)
        inputFiled.textAlignment = .center
        
        self.view.addSubview(inputFiled)
        
        let nextButton = UIButton(frame: CGRect(x: screen_w - 100, y: 0, width: 100, height: 45))
        nextButton.backgroundColor = UIColor.gray
        nextButton.setTitleColor(UIColor.black, for: .normal)
        nextButton.titleLabel?.font = UIFont.systemFont(ofSize: 22)
        nextButton.setTitle("下一题", for: .normal)
        nextButton.addTarget(self, action: #selector(nextQuestion), for: .touchUpInside)
        self.view.addSubview(nextButton)
        
        let lastButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 45))
        lastButton.backgroundColor = UIColor.gray
        lastButton.setTitleColor(UIColor.black, for: .normal)
        lastButton.titleLabel?.font = UIFont.systemFont(ofSize: 22)
        lastButton.setTitle("上一题", for: .normal)
        lastButton.addTarget(self, action: #selector(nextQuestion), for: .touchUpInside)
        self.view.addSubview(lastButton)
        
        let sureBtn = UIButton(frame: CGRect(x: (screen_w - 120)/2, y: 300, width: 120, height: 60))
//        sureBtn.backgroundColor = UIColor.green
        sureBtn.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        sureBtn.setTitleColor(UIColor.black, for: .normal)
        sureBtn.setTitle("确定", for: .normal)
        sureBtn.setBackgroundImage(UIImage(named: "sure2"), for: .normal)
        self.view.addSubview(sureBtn)
        sureBtn.addTarget(self, action: #selector(sureAction), for: .touchUpInside)
        
        let briefButton = UIButton(frame: CGRect(x: (screen_w - 60)/2, y: 370, width: 60, height: 25))
//        briefButton.backgroundColor = UIColor.gray
        briefButton.setTitleColor(UIColor.gray, for: .normal)
        briefButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        briefButton.setTitle("提示", for: .normal)
        self.view.addSubview(briefButton)
        briefButton.addTarget(self, action: #selector(briefAction), for: .touchUpInside)
        
        let popbtn = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 35))
        popbtn.setImage(UIImage(named: "back"), for: .normal)
        popbtn.addTarget(self, action: #selector(popAction), for: .touchUpInside)
        let popItem = UIBarButtonItem(customView: popbtn)
        self.navigationItem.leftBarButtonItem = popItem
        
    }
    @objc func popAction(){
        self.navigationController?.popViewController(animated: true)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        inputFiled.endEditing(true)
    }
    @objc func nextQuestion(){
        
        if(currentIndex < idiomArray.count - 1){
            inputFiled.text = ""
            currentIndex += 1
            let currentIdiom = idiomArray[currentIndex] as! String
            let currentIdiomstring = currentIdiom as NSString
            label1.text = currentIdiomstring.substring(with: NSRange(location: 0, length: 1))
            label2.text = currentIdiomstring.substring(with: NSRange(location: 1, length: 1))
            label3.text = currentIdiomstring.substring(with: NSRange(location: 2, length: 1))
            label4.text = currentIdiomstring.substring(with: NSRange(location: 3, length: 1))
            
            randomNumber = Int(arc4random() % 4) + 1
            let hideLabel = self.view.viewWithTag(randomNumber) as! UILabel
            inputFiled.frame = CGRect(x: hideLabel.frame.origin.x, y: 195, width: 40, height: 40)
        }
    }
    @objc func lastQuestion(){
       
        if(currentIndex > 0){
            inputFiled.text = ""
            currentIndex -= 1
            let currentIdiom = idiomArray[currentIndex] as! String
            let currentIdiomstring = currentIdiom as NSString
            label1.text = currentIdiomstring.substring(with: NSRange(location: 0, length: 1))
            label2.text = currentIdiomstring.substring(with: NSRange(location: 1, length: 1))
            label3.text = currentIdiomstring.substring(with: NSRange(location: 2, length: 1))
            label4.text = currentIdiomstring.substring(with: NSRange(location: 3, length: 1))
            
            randomNumber = Int(arc4random() % 4) + 1
            let hideLabel = self.view.viewWithTag(randomNumber) as! UILabel
            inputFiled.frame = CGRect(x: hideLabel.frame.origin.x, y: 195, width: 40, height: 40)
        }
    }
    @objc func sureAction(){
        let hideLabel = self.view.viewWithTag(randomNumber) as! UILabel
        if(inputFiled.text == hideLabel.text){
            print("答对了")
            WSProgressHUD.showShimmeringString("答对了，下面来学习这个成语吧！")
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                WSProgressHUD.dismiss()
            }
             let currentIdiom = idiomArray[currentIndex] as! String
            let extendItem = ExtendViewController()
//            let temObj = object as! NSDictionary
//            extendItem.idiomDictionary = temObj.object(forKey: "result") as! NSDictionary
            extendItem.idiomString = currentIdiom
            self.navigationController?.pushViewController(extendItem, animated: true)
            
        }else{
             print("答错了")
            WSProgressHUD.showShimmeringString("答错了～")
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
               WSProgressHUD.dismiss()
            }
           

            
        }
    }
    @objc func briefAction(){
         let hideLabel = self.view.viewWithTag(randomNumber) as! UILabel
        inputFiled.text = hideLabel.text;
    }


}

