//
//  UIButton+Additions.swift
//  nomura
//
//  Created by lio on 2019/6/19.
//  Copyright © 2019 lio. All rights reserved.
//

import UIKit

extension UIButton {
    func centerImageAndText(_ padding: CGFloat = 0, imageTop: Bool) {
        guard let imageView = self.imageView, let titleLabel = self.titleLabel else { return }
        let sign: CGFloat = imageTop ? 1 : -1
        let imageSize = imageView.frame.size

        self.titleEdgeInsets = UIEdgeInsets(top: (imageSize.height + padding) * sign,
                                            left: -imageSize.width,
                                            bottom: 0,
                                            right: 0)
        let titleSize = titleLabel.bounds.size
        self.imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height + padding) * sign,
                                            left: 0,
                                            bottom: 0,
                                            right: -titleSize.width)
    }

    /// Set the button image right and text left.
    ///
    /// - Parameter itemSpacing: the image and text spacing, default is 4.
    func leftTextRightImage(itemSpacing: CGFloat = 4) {
        guard let imageView = self.imageView,
            let imageSize = imageView.image?.size,
            let titleLabel = self.titleLabel else {
            return
        }

        let titleEdgeInsets = UIEdgeInsets(top: 0,
                                           left: -(imageSize.width + itemSpacing),
                                           bottom: 0,
                                           right: imageSize.width + itemSpacing)
        let imageEdgeInsets = UIEdgeInsets(top: 0,
                                           left: titleLabel.bounds.width + itemSpacing,
                                           bottom: 0,
                                           right: -(titleLabel.bounds.width + itemSpacing))

        self.titleEdgeInsets = titleEdgeInsets
        self.imageEdgeInsets = imageEdgeInsets
    }
}
