//
//  NSAttributedString+Additions.swift
//  nomura
//
//  Created by lio on 2019/6/22.
//  Copyright © 2019 lio. All rights reserved.
//

import UIKit

public extension NSMutableAttributedString {
    func apply(_ attributes: [NSAttributedString.Key: Any], range: NSRange) -> NSMutableAttributedString {
        let attributedString  = self
        attributedString.addAttributes(attributes, range: range)
        return attributedString
    }
}

public extension NSMutableAttributedString {
    func with(attributes: [NSAttributedString.Key: Any], range: Range<String.Index>? = nil) -> NSMutableAttributedString {
        var rangeNS: NSRange = NSRange(0..<self.length)
        if let range = range {
            rangeNS = NSRange(range, in: self.string)
        }
        return apply(attributes, range: rangeNS)
    }

    func with(font: UIFont, range: Range<String.Index>? = nil) -> NSMutableAttributedString {
        return with(attributes: [NSAttributedString.Key.font: font], range: range)
    }

    func with(textColor: UIColor, range: Range<String.Index>? = nil) -> NSMutableAttributedString {
        return with(attributes: [NSAttributedString.Key.foregroundColor: textColor], range: range)
    }

    func with(backgroundColor: UIColor, range: Range<String.Index>? = nil) -> NSMutableAttributedString {
        return with(attributes: [NSAttributedString.Key.backgroundColor: backgroundColor], range: range)
    }

    func with(underlineColor: UIColor, range: Range<String.Index>? = nil) -> NSMutableAttributedString {
        return with(attributes: [NSAttributedString.Key.underlineColor: underlineColor], range: range)
    }

    func with(configure: ((NSMutableParagraphStyle) -> Void), range: Range<String.Index>? = nil) -> NSMutableAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        configure(paragraphStyle)
        return with(attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle], range: range)
    }

    func with(underlineStyle: NSUnderlineStyle, range: Range<String.Index>? = nil) -> NSMutableAttributedString {
        return with(attributes: [NSAttributedString.Key.underlineStyle: underlineStyle], range: range)
    }

    func with(attachment: NSTextAttachment, range: Range<String.Index>? = nil) -> NSMutableAttributedString {
        return with(attributes: [NSAttributedString.Key.attachment: attachment], range: range)
    }
}

extension NSAttributedString {
    func height(_ width: CGFloat = CGFloat(MAXFLOAT)) -> CGFloat {
        let size = CGSize(width: width, height: CGFloat(MAXFLOAT))
        return boundingRect(with: size, options: .usesLineFragmentOrigin, context: nil).height
    }

    func width(_ height: CGFloat = CGFloat(MAXFLOAT)) -> CGFloat {
        let size = CGSize(width: CGFloat(MAXFLOAT), height: height)
        return boundingRect(with: size, options: .usesLineFragmentOrigin, context: nil).width
    }
}
