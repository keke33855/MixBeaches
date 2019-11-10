//
//  Factories.swift
//  nomura
//
//  Created by lio on 2019/7/23.
//  Copyright © 2019 lio. All rights reserved.
//

import UIKit

extension UIActivityIndicatorView {
    static func make() -> UIActivityIndicatorView {
        let view = UIActivityIndicatorView(style: .gray)
        view.hidesWhenStopped = true
        view.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
}
