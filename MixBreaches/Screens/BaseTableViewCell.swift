//
//  BaseTableViewCell.swift
//  nomura
//
//  Created by lio on 2019/6/14.
//  Copyright © 2019 lio. All rights reserved.
//

import UIKit
import RxSwift

class BaseTableViewCell: UITableViewCell {
    var disposeBag = DisposeBag()

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }

}

extension BaseTableViewCell: XibInstantiatable {}
