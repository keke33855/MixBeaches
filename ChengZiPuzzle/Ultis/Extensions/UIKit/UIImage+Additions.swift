//
//  UIImage+Additions.swift
//  nomura
//
//  Created by liofty on 2019/6/14.
//  Copyright © 2019 lio. All rights reserved.
//

import UIKit

extension UIImage {
    class func image(from color: UIColor) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let img: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }
}

extension UIImage {
    var renderOriginal: UIImage {
        return withRenderingMode(.alwaysOriginal)
    }

    var renderTemplate: UIImage {
        return withRenderingMode(.alwaysTemplate)
    }
}
