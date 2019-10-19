//
//  BaseViewController.swift
//  JiPaiQi
//
//  Created by jf on 2019/9/2.
//  Copyright © 2019 lixi. All rights reserved.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController {
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    deinit {
        print("[DEBUG]: \(String(describing: self.classForCoder)) deinit")
    }
}
