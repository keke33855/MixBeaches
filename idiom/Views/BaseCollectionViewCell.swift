//
//  BaseCollectionViewCell.swift
//  nomura
//
//  Created by lio on 2019/6/14.
//  Copyright © 2019 lio. All rights reserved.
//

import UIKit
import RxSwift

class BaseCollectionViewCell: UICollectionViewCell {
    var disposeBag = DisposeBag()

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
}

extension BaseCollectionViewCell: XibInstantiatable {}
