//
//  UIView+Additions.swift
//  nomura
//
//  Created by lio on 2019/6/13.
//  Copyright © 2019 lio. All rights reserved.
//

import UIKit

extension UIView {

    @IBInspectable var borderColor: UIColor? {
        get {
            return self.layer.borderColor.map { UIColor(cgColor: $0) }
        }
        set {
            self.layer.borderColor = newValue?.cgColor
        }
    }

    @IBInspectable var borderWidth: CGFloat {
        get {
            return self.layer.borderWidth
        }
        set {
            self.layer.borderWidth = newValue
        }
    }

    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
            self.layer.masksToBounds = newValue > 0
        }
    }

}

extension UIView {
    var safeAreaBottomInset: CGFloat {
        if #available(iOS 11.0, *) {
            return safeAreaInsets.bottom
        } else {
            return 0
        }
    }
}

extension UIView {
    func applyGradient(colors: [UIColor], locations: [NSNumber]? = nil) {
        let gradient = CAGradientLayer()
        gradient.colors = colors.map { $0.cgColor }
        gradient.locations = locations
        self.setNeedsLayout()
        gradient.frame = self.bounds
        self.layer.insertSublayer(gradient, at: 0)
    }
}

public extension UIView {
    func addChildView(_ child: UIView, insets: UIEdgeInsets = .zero) {
        self.addSubview(child)
        child.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                child.topAnchor.constraint(equalTo: topAnchor, constant: insets.top),
                child.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -insets.right),
                child.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -insets.bottom),
                child.leftAnchor.constraint(equalTo: leftAnchor, constant: insets.left),
            ]
        )
    }

    func addCenterChildView(_ child: UIView, center: CGPoint = .zero) {
        self.addSubview(child)
        child.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                child.centerXAnchor.constraint(equalTo: centerXAnchor, constant: center.x),
                child.centerYAnchor.constraint(equalTo: centerYAnchor, constant: center.y),
            ]
        )
    }
}

extension UIView {

    func convertToImage() -> UIImage? {
        var viewImage: UIImage?

        if let scrollView = self as? UIScrollView {
            let savedContentOffset = scrollView.contentOffset
            let savedFrame = frame

            UIGraphicsBeginImageContextWithOptions(scrollView.contentSize, false, UIScreen.main.scale)

            scrollView.contentOffset = .init(x: 0, y: 72) //CGPoint.zero
            frame = CGRect(x: 0, y: 0, width: scrollView.contentSize.width, height: scrollView.contentSize.height)

            if let context = UIGraphicsGetCurrentContext() {
                layer.render(in: context)
                viewImage = UIGraphicsGetImageFromCurrentImageContext()
            }

            UIGraphicsEndImageContext()

            scrollView.contentOffset = savedContentOffset
            scrollView.frame = savedFrame
        } else {
            UIGraphicsBeginImageContextWithOptions(frame.size, false, UIScreen.main.scale)
            if let currentContext = UIGraphicsGetCurrentContext() {
                layer.render(in: currentContext)
                if let image = UIGraphicsGetImageFromCurrentImageContext() {
                    viewImage = image
                }
            }
            UIGraphicsEndImageContext()
        }

        return viewImage
    }

}
