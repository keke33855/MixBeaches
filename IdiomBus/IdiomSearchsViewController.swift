//
//  IdiomSearchViewController.swift
//  idiom
//
//  Created by chang on 2022/8/22.
//  Copyright © 2019 chang. All rights reserved.
//

import UIKit

class IdiomSearchsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        let keyUnicode = searchBar.text!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
//        https://api.jisuapi.com/chengyu/search?appkey=e3a803eb7734d0b6&keyword=叶
        let searchurl = "https://api.jisuapi.com/chengyu/search?appkey=e3a803eb7734d0b6&keyword=" + keyUnicode
       let managet =  AFHTTPSessionManager()
        managet.get(searchurl, parameters: nil, progress: { (pro) in
            
        }, success: { (task, object) in
            print(object)
            let resultObj = object as! NSDictionary
            self.idiomList = resultObj.object(forKey: "result") as! NSArray
            self.searchTableView.reloadData()
        }) { (task2, error) in
            
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let extendvc = IdiomDescViewController()
        let itemObj = idiomList[indexPath.row] as! NSDictionary
        let idiomstr = itemObj.object(forKey: "name") as! String
        extendvc.idiomString = idiomstr
        self.navigationController?.pushViewController(extendvc, animated: true)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return idiomList.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "cellIdentifier"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        if (cell == nil) {
            cell = UITableViewCell(style: .value1, reuseIdentifier: cellIdentifier)
        }
        let itemObj = idiomList[indexPath.row] as! NSDictionary
        cell?.textLabel?.text = itemObj.object(forKey: "name") as! String
        cell?.contentView.backgroundColor = UIColor.clear
        cell?.backgroundColor = UIColor.clear
        cell?.selectionStyle = .none
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 35)
        return cell as! UITableViewCell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }

    var idiomList = NSArray()
    var searchTableView = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "成语搜索"
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        let bcakImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: screen_w , height: screen_H))
        bcakImageView.image = UIImage(named: "idiomBack")
        self.view.addSubview(bcakImageView)
        let idiomSearchBar = UISearchBar(frame: CGRect(x: 12, y: 10, width: screen_w - 24, height: 35))
        idiomSearchBar.keyboardType = .webSearch
        idiomSearchBar.delegate = self
        idiomSearchBar.layer.borderWidth = 1
        idiomSearchBar.layer.borderColor = UIColor.gray.cgColor
        idiomSearchBar.backgroundColor = UIColor.white

        
        
        searchTableView = UITableView(frame: CGRect(x: 0, y: 0, width: screen_w, height: screen_H - 64))
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchTableView.backgroundColor = UIColor.clear
        self.view.addSubview(searchTableView)
        searchTableView.keyboardDismissMode = .onDrag
        searchTableView.tableFooterView = UIView()
        
        let searchHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: screen_w, height: 50))
        searchHeaderView.addSubview(idiomSearchBar)
        searchTableView.tableHeaderView = searchHeaderView;
        idiomSearchBar.layer.cornerRadius = 4
        
        for subView in idiomSearchBar.subviews {
            for view in subView.subviews {
                if view.isKind(of:NSClassFromString("UISearchBarBackground")!) {
                    let imageView = view as! UIImageView
                    imageView.removeFromSuperview()
                }
            }
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
