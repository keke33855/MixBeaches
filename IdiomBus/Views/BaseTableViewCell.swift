//
//  BaseTableViewCell.swift
//  nomura
//
//  Created by lio on 2019/6/14.
//  Copyright © 2019 lio. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    var disposeBag = DisposeBag()

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.dividingLine()?.backgroundColor = UIColor(hex: 0xD8D8D8)
    }

    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        self.dividingLine()?.backgroundColor = UIColor(hex: 0xD8D8D8)
    }

}

extension BaseTableViewCell: XibInstantiatable {}

extension BaseTableViewCell: DividingLineable {}
