//
//  UIButton+kf.swift
//  JiPaiQi
//
//  Created by jf on 2019/9/4.
//  Copyright © 2019 lixi. All rights reserved.
//

import Foundation

extension UIButton {
    func setImage(_ urlString: String?, placeholder: UIImage? = nil) {
        guard let urlString = urlString, !urlString.isEmpty else { return }
        self.setImage(URL(string: urlString), placeholder: placeholder)
    }
    
    func setImage(_ url: URL?, placeholder: UIImage? = nil) {
        self.kf.setImage(with: url, for: .normal, placeholder: placeholder)
    }
    
    func cancelRequest() {
        self.kf.cancelImageDownloadTask()
    }
}
