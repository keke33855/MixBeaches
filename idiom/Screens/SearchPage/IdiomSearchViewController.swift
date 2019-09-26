//
//  IdiomSearchViewController.swift
//  idiom
//
//  Created by jf on 2019/9/26.
//  Copyright © 2019 chang. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Moya

class IdiomSearchViewController: BaseViewController {

    @IBOutlet weak var searchTextfield: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    private var idiomList: [IdiomResult] = []
    private var apiService = APIs()
    
    private var keywordSearchOb = PublishRelay<String?>()
    
    // MAKR: - life cycle
    static func instance() -> IdiomSearchViewController {
        return IdiomSearchViewController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        bindAction()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        searchTextfield.becomeFirstResponder()
    }
    
    private func setupView() {
        tableView.hideEmptyCells()
        tableView.disableEstimatedHeight()
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
    }

    // MARK: - action
    private func bindAction() {
        keywordSearchOb.filterNil()
            .flatMap {
                self.apiService.request(target: APITarget.searchIdiom($0))
                    .mapObject(SearchResultModel.self)
            }
            .map { $0.result ?? [] }
            .subscribe(onNext: { [weak self] results in
                self?.idiomList = results
                self?.tableView.reloadData()
            })
            .disposed(by: disposeBag)
    }
    
    @IBAction func backBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension IdiomSearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return idiomList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "cellIdentifier"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        if (cell == nil) {
            cell = UITableViewCell(style: .value1, reuseIdentifier: cellIdentifier)
        }
        cell?.textLabel?.text = idiomList[indexPath.row].name
        cell?.contentView.backgroundColor = UIColor.clear
        cell?.backgroundColor = UIColor.clear
        cell?.selectionStyle = .none
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 20)
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let idiomString = idiomList.safeElement(indexPath.row)?.name {
            let extendvc = IdiomDescViewController()
            extendvc.idiomString = idiomString
            self.navigationController?.pushViewController(extendvc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
}

extension IdiomSearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        keywordSearchOb.accept(textField.text)
        return true
    }
}
