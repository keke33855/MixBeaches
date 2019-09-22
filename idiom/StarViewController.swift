//
//  StarViewController.swift
//  idiom
//
//  Created by chang on 2022/8/23.
//  Copyright © 2019 chang. All rights reserved.
//

import UIKit

class StarViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
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
        cell?.textLabel?.text = starArray[indexPath.row] as! String
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 30)
        cell?.selectionStyle = .none
        return cell as! UITableViewCell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let infovc = ExtendViewController()
        infovc.idiomString = starArray[indexPath.row] as! String
        self.navigationController?.pushViewController(infovc, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    

    var starTableView = UITableView()
    var starArray = NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "我的收藏"
        let bcakImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: screen_w , height: screen_H))
        bcakImageView.image = UIImage(named: "infoBack")
        self.view.addSubview(bcakImageView)

        starArray = NSMutableArray(capacity: 10)
          let users = UserDefaults.standard
        if((users.value(forKey: STARIDIOM)) != nil){
             let tempArray = users.value(forKey: STARIDIOM) as! NSArray
            starArray.addObjects(from: tempArray as! [Any])
        }
        starTableView = UITableView(frame: CGRect(x: 0, y: 0, width: screen_w, height: screen_H))
        starTableView.delegate = self
        starTableView.dataSource = self
        starTableView.backgroundColor = UIColor.clear
        self.view.addSubview(starTableView)
        starTableView.separatorStyle = .none
        starTableView.tableFooterView = UIView()
        // Do any additional setup after loading the view.
        let popbtn = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 35))
        popbtn.setImage(UIImage(named: "back"), for: .normal)
        popbtn.addTarget(self, action: #selector(popAction), for: .touchUpInside)
        let popItem = UIBarButtonItem(customView: popbtn)
        self.navigationItem.leftBarButtonItem = popItem
        
    }
    @objc func popAction(){
        self.navigationController?.popViewController(animated: true)
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
