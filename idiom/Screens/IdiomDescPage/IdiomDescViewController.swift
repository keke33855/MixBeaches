//
//  IdiomDescViewController.swift
//  idiom
//
//  Created by jf on 2019/9/26.
//  Copyright © 2019 chang. All rights reserved.
//

import UIKit
import AVFoundation
import RxSwift
import RxCocoa

class IdiomDescViewController: BaseViewController {

    @IBOutlet weak var favoriteBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var speechBtn: UIButton!
    var idiomLabel: UILabel!
    var pronounceLabel: UILabel!
    
    var idiomDictionary = NSDictionary()
    var idiomString: String?
    var idiomDescription: IdiomDescModel?
    
    private var apiService = APIs()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        bindAction()
    }

    private func setupView() {
        tableView.hideEmptyCells()
        tableView.disableEstimatedHeight()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        
        let tableheaderview = UIView(frame: CGRect(x: 0, y: 0, width: Const.screenWidth, height: 100))
        tableView.tableHeaderView = tableheaderview
        
        idiomLabel = UILabel(frame: CGRect(x: 0, y: 20, width: Const.screenWidth, height: 25))
        idiomLabel.font = UIFont.systemFont(ofSize: 20)
        idiomLabel.textColor = UIColor.gray
        idiomLabel.textAlignment = .center
        tableheaderview.addSubview(idiomLabel)
        
        pronounceLabel = UILabel(frame: CGRect(x: 0, y: 55, width: Const.screenWidth, height: 25))
        pronounceLabel.font = UIFont.systemFont(ofSize: 24)
        pronounceLabel.textColor = UIColor.black
        pronounceLabel.textAlignment = .center
        tableheaderview.addSubview(pronounceLabel)
        
        speechBtn = UIButton(frame: CGRect(x: Const.screenWidth - 50, y: 20, width: 28, height: 28))
        speechBtn.setImage(UIImage(named: "play"), for: .normal)
        tableheaderview.addSubview(speechBtn)
        speechBtn.rx.tap
            .asDriver()
            .debounce(0.1)
            .drive(onNext: { [weak self] in
                self?.speechAction()
            })
            .disposed(by: disposeBag)
    }
    
    private func bindAction() {
        favoriteBtn.rx.tap
            .asDriver()
            .debounce(0.1)
            .drive(onNext: { [weak self] in
                self?.saveIdiomToFavorite()
            })
            .disposed(by: disposeBag)
        
        Observable.just(self.idiomString)
            .filterNil()
            .flatMap {
                self.apiService.request(target: APITarget.idiomDescription($0))
                    .mapResponse(key: "result")
                    .mapObject(IdiomDescModel.self)
            }
            .subscribe(onNext: { [weak self] (idiomModel) in
                self?.idiomDescription = idiomModel
                self?.idiomLabel.text = idiomModel.name
                self?.pronounceLabel.text = idiomModel.pronounce
                self?.tableView.reloadData()
            })
            .disposed(by: disposeBag)
    }

    @IBAction func backBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func saveIdiomToFavorite() {
        if let idiom = self.idiomString {
            let users = UserDefaults.standard
            let starArray = NSMutableArray.init(capacity: 10)
            if((users.value(forKey: STARIDIOM)) != nil){
                let tempArray = users.value(forKey: STARIDIOM) as! NSArray
                starArray.addObjects(from: tempArray as! [Any])
            }
            starArray.add(idiom)
            users.set(starArray, forKey: STARIDIOM)
            favoriteBtn.setImage(UIImage(named: "star_1"), for: .normal)
        }
    }
    
    // 朗读
    @objc func speechAction(){
        let syntesizer = AVSpeechSynthesizer()
        var utterance = AVSpeechUtterance()
        
        
        utterance = AVSpeechUtterance(string: self.idiomString ?? "")
        utterance.rate = 0.5
        syntesizer.speak(utterance)
    }
}

extension IdiomDescViewController: UITableViewDelegate, UITableViewDataSource {
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
        
        let xyImageView = UIImageView(frame: CGRect(x: (screen_w - 220)/2, y: 0, width: 220, height: 30))
        xyImageView.image = UIImage(named: "xiangyun")
        idiomSectionHeaderView.addSubview(xyImageView)
        
        let sectionTitleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: screen_w, height: 30))
        sectionTitleLabel.textAlignment = .center
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
        
        var labelSize = CGSize(width: screen_w - 24, height: 44)
        if self.idiomDescription?.content != nil {
            switch indexPath.section {
            case 0:
                contentLabel.text = self.idiomDescription?.content
            case 1:
                contentLabel.text = self.idiomDescription?.comefrom
            case 2:
                contentLabel.text = self.idiomDescription?.antonym?.joined(separator: ",")
            case 3:
                contentLabel.text = self.idiomDescription?.thesaurus?.joined(separator: ",")
            case 4:
                contentLabel.text = self.idiomDescription?.example
            default:
                contentLabel.text = nil
            }
        }
        
        labelSize = ToolsViewController.getsize(with: contentLabel.text ?? "",
                                                font: 17,
                                                maxSize: CGSize(width: screen_w - 24,
                                                                height: screen_H)) as CGSize
        contentLabel.frame = CGRect(x: 12, y: 8, width: screen_w - 24, height: labelSize.height)
        cell?.contentView.backgroundColor = UIColor.clear
        cell?.backgroundColor = UIColor.clear
        cell?.selectionStyle = .none
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var hightString: String?
        if let idiomDesc = self.idiomDescription,
            idiomDesc.content != nil {
            switch indexPath.section {
            case 0:
                hightString = idiomDesc.content
            case 1:
                hightString = idiomDesc.comefrom
            case 2:
                hightString = idiomDesc.antonym?.joined(separator: ",")
            case 3:
                hightString = idiomDesc.thesaurus?.joined(separator: ",")
            case 4:
                hightString = idiomDesc.example
            default:
                hightString = nil
            }
        }
        
        let labelSize = ToolsViewController.getsize(with: hightString ?? "",
                                                    font: 17,
                                                    maxSize: CGSize(width: screen_w - 24, height: screen_H)) as CGSize
        return labelSize.height + 16 + 20
    }
}
