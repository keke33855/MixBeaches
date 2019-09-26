//
//  ExtendViewController.swift
//  idiom
//
//  Created by chang on 2022/8/22.
//  Copyright © 2019 chang. All rights reserved.
//

import UIKit
import AVFoundation

class ExtendViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var hightString = ""
        if((self.idiomDictionary.object(forKey: "content")) != nil){
            switch indexPath.section {
            case 0  :
                if(idiomDictionary.object(forKey: "content") is NSNull){
                    
                }else{
                     hightString = (self.idiomDictionary.object(forKey: "content") as! String)
                }
               
                break
            case 1 :
                if(idiomDictionary.object(forKey: "comefrom") is NSNull){
                    
                }else{
                    hightString = (self.idiomDictionary.object(forKey: "comefrom") as! String)

                }
                break
            case 2 :
                if(idiomDictionary.object(forKey: "antonym") is NSArray){
                    let array = self.idiomDictionary.object(forKey: "antonym") as! NSArray
                    var antonymstr = ""
                    for i in 0...array.count - 1 {
                        let itemString = array[i] as! String
                        if(i == 0){
                            antonymstr = itemString
                        }else{
                            antonymstr = antonymstr + "," + itemString
                        }
                    }
                    hightString = antonymstr
                }else{
                   
                }
                
                break
            case 3 :
                 if(idiomDictionary.object(forKey: "thesaurus") is NSArray){
                    let array = self.idiomDictionary.object(forKey: "thesaurus") as! NSArray
                    var antonymstr = ""
                    for i in 0...array.count - 1 {
                        let itemString = array[i] as! String
                        if(i == 0){
                            antonymstr = itemString
                        }else{
                            antonymstr = antonymstr + "," + itemString
                        }
                    }
                    hightString = antonymstr
                 }
                
                break
            case 4 :
                hightString = (self.idiomDictionary.object(forKey: "example") as! String)
                break
                
                //        default :
            //             fallthrough
            default: break
                
            }
        }
        
        let labelSize = ToolsViewController.getsize(with: hightString, font: 17, maxSize: CGSize(width: screen_w - 24, height: screen_H)) as CGSize
        return labelSize.height + 16 + 20
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let idiomSectionHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: screen_w, height: 30))
//        idiomSectionHeaderView.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        
        let xyImageView = UIImageView(frame: CGRect(x: (screen_w - 220)/2, y: 0, width: 220, height: 30))
        xyImageView.image = UIImage(named: "xiangyun")
        idiomSectionHeaderView.addSubview(xyImageView)
        
        let sectionTitleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: screen_w, height: 30))
        sectionTitleLabel.textAlignment = .center
//        sectionTitleLabel.textColor = UIColor.gray
        sectionTitleLabel.font = UIFont.systemFont(ofSize: 15)
        idiomSectionHeaderView.addSubview(sectionTitleLabel)
        switch section {
        case 0  :
            sectionTitleLabel.text = "大意"
            break
        case 1 :
            sectionTitleLabel.text = "出处"
            break
        case 2 :
            sectionTitleLabel.text = "反义词"
            break
        case 3 :
            sectionTitleLabel.text = "同义词"
            break
        case 4 :
            sectionTitleLabel.text = "举例"
            break
            
//        default :
//             fallthrough
        default: break
            
        }
        return idiomSectionHeaderView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "cellIdentifier"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        if (cell == nil) {
            cell = UITableViewCell(style: .value1, reuseIdentifier: cellIdentifier)
            
            let contentLabel = UILabel(frame: CGRect(x: 12, y: 8, width: screen_w - 24, height: 40))
            contentLabel.font = UIFont.systemFont(ofSize: 17)
            contentLabel.textColor = UIColor.black
            contentLabel.tag = 11
            contentLabel.numberOfLines = 0
            cell?.contentView.addSubview(contentLabel)
        }
        let contentLabel = cell?.contentView.viewWithTag(11) as! UILabel
        contentLabel.text = ""
        if((self.idiomDictionary.object(forKey: "content")) != nil){
            switch indexPath.section {
            case 0  :
                if(idiomDictionary.object(forKey: "content") is NSNull){
                    
                }else{
                    contentLabel.text = (self.idiomDictionary.object(forKey: "content") as! String)
                }
               
                break
            case 1 :
                if(idiomDictionary.object(forKey: "comefrom") is NSNull){
                    
                }else{
                    contentLabel.text = (self.idiomDictionary.object(forKey: "comefrom") as! String)
                }
                
                break
            case 2 :
                if(idiomDictionary.object(forKey: "antonym") is NSArray){
                    let array = self.idiomDictionary.object(forKey: "antonym") as! NSArray
                    var antonymstr = ""
                    for i in 0...array.count - 1 {
                        let itemString = array[i] as! String
                        if(i == 0){
                            antonymstr = itemString
                        }else{
                            antonymstr = antonymstr + "," + itemString
                        }
                    }
                    contentLabel.text = antonymstr
                }else{
                    
                }
                
                break
            case 3 :
                  if(idiomDictionary.object(forKey: "thesaurus") is NSArray){
                    let array = self.idiomDictionary.object(forKey: "thesaurus") as! NSArray
                    var antonymstr = ""
                    for i in 0...array.count - 1 {
                        let itemString = array[i] as! String
                        if(i == 0){
                            antonymstr = itemString
                        }else{
                            antonymstr = antonymstr + "," + itemString
                        }
                    }
                    contentLabel.text = antonymstr
                  }
               
                break
            case 4 :
                contentLabel.text = (self.idiomDictionary.object(forKey: "example") as! String)
                break
                
                //        default :
            //             fallthrough
            default: break
                
            }
        }
        
       let labelSize = ToolsViewController.getsize(with: contentLabel.text!, font: 17, maxSize: CGSize(width: screen_w - 24, height: screen_H)) as CGSize
        contentLabel.frame = CGRect(x: 12, y: 8, width: screen_w - 24, height: labelSize.height)
        cell?.contentView.backgroundColor = UIColor.clear
        cell?.backgroundColor = UIColor.clear
        cell?.selectionStyle = .none
        return cell as! UITableViewCell
    }
    

    var idiomDictionary = NSDictionary()
    var idiomString = String()
    var idiomTableView = UITableView()
    var starButton = UIButton()
    var playButton  = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = idiomString
        let bcakImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: screen_w , height: screen_H))
        bcakImageView.image = UIImage(named: "infoBack")
        self.view.addSubview(bcakImageView)
        starButton = UIButton(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
        starButton.setImage(UIImage(named: "star_0"), for: .normal)
        let leftItem = UIBarButtonItem(customView: starButton)
        self.navigationItem.rightBarButtonItem = leftItem
        starButton.addTarget(self, action: #selector(starAction), for: .touchUpInside)
        
        let users = UserDefaults.standard
        if((users.value(forKey: STARIDIOM)) != nil){
            let tempArray = users.value(forKey: STARIDIOM) as! NSArray
            if tempArray.contains(idiomString){
                 starButton.setImage(UIImage(named: "star_1"), for: .normal)
                starButton.isUserInteractionEnabled = false
            }
        }
        
        
        idiomTableView = UITableView(frame: CGRect(x: 0, y: 0, width: screen_w, height: screen_H))
        idiomTableView.delegate = self
        idiomTableView.dataSource = self
        idiomTableView.backgroundColor = UIColor.clear
        self.view.addSubview(idiomTableView)
        idiomTableView.tableFooterView = UIView()
        
        let tableheaderview = UIView(frame: CGRect(x: 0, y: 0, width: screen_w, height: 100))
        idiomTableView.tableHeaderView = tableheaderview
        let idiomLabel = UILabel(frame: CGRect(x: 0, y: 20, width: screen_w, height: 25))
        idiomLabel.font = UIFont.systemFont(ofSize: 20)
        idiomLabel.textColor = UIColor.gray
        idiomLabel.textAlignment = .center
        tableheaderview.addSubview(idiomLabel)
        
        let pronounceLabel = UILabel(frame: CGRect(x: 0, y: 55, width: screen_w, height: 25))
        pronounceLabel.font = UIFont.systemFont(ofSize: 24)
        pronounceLabel.textColor = UIColor.black
        pronounceLabel.textAlignment = .center
        tableheaderview.addSubview(pronounceLabel)
        
        playButton = UIButton(frame: CGRect(x: screen_w - 50, y: 20, width: 28, height: 28))
        playButton.setImage(UIImage(named: "play"), for: .normal)
        tableheaderview.addSubview(playButton)
        playButton.addTarget(self, action: #selector(playAction), for: .touchUpInside)
        


        // Do any additional setup after loading the view.
        
        let keyUnicode = idiomString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlstr = "https://api.jisuapi.com/chengyu/detail?appkey=e3a803eb7734d0b6&chengyu=" + keyUnicode
        let manager = AFHTTPSessionManager()
        manager.get(urlstr, parameters: nil, progress: { (pro) in
            
        }, success: { (task, object) in
            print(object)
            let itemObj = object as! NSDictionary
            self.idiomDictionary = itemObj.object(forKey: "result") as! NSDictionary
            idiomLabel.text = self.idiomDictionary.object(forKey: "pronounce") as! String
            pronounceLabel.text = self.idiomDictionary.object(forKey: "name") as! String
            
//            let lsize = ToolsViewController.getsize(with: pronounceLabel.text!, font: 24, maxSize: CGSize(width: screen_w, height: 25))
            

            self.idiomTableView.reloadData()
            
        }) { (task2, error) in
            
        }
        let popbtn = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 35))
        popbtn.setImage(UIImage(named: "back"), for: .normal)
        popbtn.addTarget(self, action: #selector(popAction), for: .touchUpInside)
        let popItem = UIBarButtonItem(customView: popbtn)
        self.navigationItem.leftBarButtonItem = popItem
        
    }
    @objc func popAction(){
        self.navigationController?.popViewController(animated: true)
    }
    @objc func playAction(){
        let syntesizer = AVSpeechSynthesizer()
        var utterance = AVSpeechUtterance()
        
        
        utterance = AVSpeechUtterance(string: idiomString)
        utterance.rate = 0.5
        syntesizer.speak(utterance)
    }
    @objc func starAction(){
        let users = UserDefaults.standard
        let starArray = NSMutableArray.init(capacity: 10)
        if((users.value(forKey: STARIDIOM)) != nil){
            let tempArray = users.value(forKey: STARIDIOM) as! NSArray
            starArray.addObjects(from: tempArray as! [Any])
        }
        starArray.add(self.idiomString)
        users.set(starArray, forKey: STARIDIOM)
        starButton.setImage(UIImage(named: "star_1"), for: .normal)
        
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
