//
//  UITableView+Additions.swift
//  nomura
//
//  Created by lio on 2019/6/13.
//  Copyright © 2019 lio. All rights reserved.
//

import UIKit

extension UITableView {
    public func reloadData(_ completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0.0, animations: {
            self.reloadData()
        }, completion: { _ in
            completion()
        })
    }
}

extension UITableView {

    func hideGroupedHeader() {
        let size = CGSize(width: UIScreen.width, height: 0.001)
        self.tableHeaderView = UIView(frame: .init(origin: .zero, size: size))
    }

    func hideEmptyCells() {
        self.tableFooterView = UIView(frame: .zero)
    }

    func disableEstimatedHeight() {
        self.estimatedRowHeight = 0.0
        self.estimatedSectionHeaderHeight = 0.0
        self.estimatedSectionFooterHeight = 0.0
    }
}

extension UITableView {

    func register<T: UITableViewCell>(_ type: T.Type) {
        register(type.self, forCellReuseIdentifier: type.className)
    }

    func register<T: UITableViewCell>(_ type: T.Type) where T: XibInstantiatable {
        register(type.nib, forCellReuseIdentifier: type.className)
    }

    func registerHeaderFooterview<T: UITableViewHeaderFooterView>(_ type: T.Type) {
        register(type.self, forHeaderFooterViewReuseIdentifier: type.className)
    }

    func registerHeaderFooterview<T: UITableViewHeaderFooterView>(_ type: T.Type) where T: XibInstantiatable {
        register(type.nib, forHeaderFooterViewReuseIdentifier: type.className)
    }

    func dequeueReusableCell<T: UITableViewCell>(_ type: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: type.className, for: indexPath) as? T else {
            fatalError("Couldn't find nib file for `\(type.className)`")
        }
        return cell
    }

    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(_ type: T.Type) -> T {
        let dequeueView = self.dequeueReusableHeaderFooterView(withIdentifier: type.className) as? T
        guard let headerFooterView = dequeueView else {
            fatalError("Couldn't find nib file for `\(type.className)`")
        }
        return headerFooterView
    }

}
