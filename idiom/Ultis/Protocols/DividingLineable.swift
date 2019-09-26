//
//  DividingLineable.swift
//  nomura
//
//  Created by liofty on 2019/6/18.
//  Copyright © 2019 lio. All rights reserved.
//

import Foundation
import UIKit

private let lineKey = "dividingLine"

enum DividingLinePosition {
    case top
    case bottom
}

protocol DividingLineable: class {

}

extension DividingLineable where Self: UIView {

    func addDividingView(_ position: DividingLinePosition = .bottom,
                         forKey key: String = lineKey,
                         left: CGFloat = 0,
                         right: CGFloat = 0,
                         height: CGFloat = 1) {
        guard self.dividingLine(forKey: key)?.superview == nil else { return }
        let lineView = UIImageView(frame: .zero)
        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.clipsToBounds = true
        lineView.contentMode = .scaleAspectFill
        lineView.image = UIImage.image(from: UIColor(hex: 0xD8D8D8))

        func getConstraint() -> NSLayoutConstraint {
            switch position {
            case .top:
                return lineView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0)
            case .bottom:
                return lineView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
            }
        }

        self.addSubview(lineView)
        NSLayoutConstraint.activate([
            lineView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: left),
            lineView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: right),
            lineView.heightAnchor.constraint(equalToConstant: height),
            getConstraint(),
        ])
        objc_setAssociatedObject(self, key, lineView, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }

    func removeDividingView(forKey key: String = lineKey) {
        self.dividingLine(forKey: key)?.removeFromSuperview()
    }

    func dividingLine(forKey key: String = lineKey) -> UIImageView? {
        return objc_getAssociatedObject(self, key) as? UIImageView
    }
}
