//
//  UIImageView+kf.swift
//  nomura
//
//  Created by lio on 2019/6/15.
//  Copyright © 2019 lio. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {

    func setImage(_ urlString: String?, placeholder: UIImage? = nil) {
        guard let urlString = urlString, !urlString.isEmpty else { return }
        self.setImage(URL(string: urlString), placeholder: placeholder)
    }

    func setImage(_ url: URL?, placeholder: UIImage? = nil) {
        self.kf.setImage(with: url, placeholder: placeholder)
    }

    func cancelRequest() {
        self.kf.cancelDownloadTask()
    }
}
