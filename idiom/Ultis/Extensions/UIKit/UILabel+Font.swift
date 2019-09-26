//
//  UILabel+Font.swift
//  nomura
//
//  Created by liofty on 2019/6/14.
//  Copyright © 2019 lio. All rights reserved.
//

import UIKit

extension UILabel {

    @IBInspectable
    var hiraginoSansBold: Bool {
        get {
            return self.font.fontName == UIFont.FontName.hirakakuProNW6.rawValue
        }
        set {
            let w6 = UIFont.font(name: .hiraginoSansW6, size: hiraginoSansFontSize)
            let w3 = UIFont.font(name: .hiraginoSansW3, size: hiraginoSansFontSize)
            self.font = newValue ? w6 : w3
        }
    }

    @IBInspectable
    var hiraginoSansFontSize: CGFloat {
        get {
            return self.font.pointSize
        }
        set {
            let w6 = UIFont.font(name: .hiraginoSansW6, size: newValue)
            let w3 = UIFont.font(name: .hiraginoSansW3, size: newValue)
            self.font = hiraginoSansBold ? w6 : w3
        }
    }

}
