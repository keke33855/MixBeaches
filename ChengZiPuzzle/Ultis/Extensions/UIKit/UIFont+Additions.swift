//
//  UIFont+Additions.swift
//  nomura
//
//  Created by lio on 2019/6/13.
//  Copyright © 2019 lio. All rights reserved.
//

import UIKit

extension UIFont {
    class func font(name: String, size: CGFloat) -> UIFont {
        guard let font = UIFont(name: name, size: size) else {
            return UIFont.systemFont(ofSize: size)
        }
        return font
    }
}

extension UIFont {
    enum FontName: String {
        case hirakakuProNW3 = "HiraKakuProN-W3"
        case hirakakuProNW6 = "HiraKakuProN-W6"
        case hiraginoSansW6 = "HiraginoSans-W6"
        case hiraginoSansW3 = "HiraginoSans-W3"
    }

    class func font(name: UIFont.FontName, size: CGFloat) -> UIFont {
        return self.font(name: name.rawValue, size: size)
    }

    class func hirakakuProNW3(size: CGFloat) -> UIFont {
        return UIFont.font(name: .hirakakuProNW3, size: size)
    }

    class func hirakakuProNW6(size: CGFloat) -> UIFont {
        return UIFont.font(name: .hirakakuProNW6, size: size)
    }
}

extension UIFont {
    func with(_ traits: UIFontDescriptor.SymbolicTraits...) -> UIFont {
        guard let descriptor = self.fontDescriptor
            .withSymbolicTraits(UIFontDescriptor.SymbolicTraits(traits)
            .union(self.fontDescriptor.symbolicTraits)) else {
            return self
        }
        return UIFont(descriptor: descriptor, size: 0)
    }

    func without(_ traits: UIFontDescriptor.SymbolicTraits...) -> UIFont {
        guard let descriptor = self.fontDescriptor.withSymbolicTraits(self.fontDescriptor
            .symbolicTraits
            .subtracting(UIFontDescriptor.SymbolicTraits(traits))) else {
            return self
        }
        return UIFont(descriptor: descriptor, size: 0)
    }
}
