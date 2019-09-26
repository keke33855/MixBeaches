//
//  FavoriteViewController.swift
//  idiom
//
//  Created by jf on 2019/9/26.
//  Copyright © 2019 chang. All rights reserved.
//

import UIKit

class FavoriteViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var starArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    private func setupView() {
        starArray = NSMutableArray(capacity: 10)
        let users = UserDefaults.standard
        if((users.value(forKey: STARIDIOM)) != nil){
            let tempArray = users.value(forKey: STARIDIOM) as! NSArray
            starArray.addObjects(from: tempArray as! [Any])
        }
        
        tableView.hideEmptyCells()
        tableView.disableEstimatedHeight()
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
    }

    @IBAction func backBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return starArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "cellIdentifier"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        if (cell == nil) {
            cell = UITableViewCell(style: .value1, reuseIdentifier: cellIdentifier)
        }
        cell?.contentView.backgroundColor = UIColor.clear
        cell?.backgroundColor = UIColor.clear
        cell?.textLabel?.text = starArray[indexPath.row] as? String
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 30)
        cell?.selectionStyle = .none
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let infovc = IdiomDescViewController()
        infovc.idiomString = starArray[indexPath.row] as? String
        self.navigationController?.pushViewController(infovc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
