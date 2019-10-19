//
//  UIActivityController+Addtion.swift
//  nomura
//
//  Created by wanglei on 2019/7/16.
//  Copyright © 2019 lio. All rights reserved.
//

import Foundation
import UIKit

final class SafariActivity: UIActivity {

    let title: String?
    let url: URL?

    init(title: String, url: URL?) {
        self.title = title
        self.url = url
        super.init()
    }

    override var activityTitle: String? {
        return title
    }

    override var activityImage: UIImage? {
        return #imageLiteral(resourceName: "img_activity_icn__safari")
    }

    override func canPerform(withActivityItems activityItems: [Any]) -> Bool {
        guard let url = url else { return false }
        return UIApplication.shared.canOpenURL(url)
    }

    override func prepare(withActivityItems activityItems: [Any]) {

    }

    override func perform() {
        guard let url = url else { return }
        openURL(url)
        self.activityDidFinish(true)
    }
}

extension UIActivityViewController {

    public static func share(item: [Any], needSafariActivity: Bool = false) {

        let shareItem = item.map { element -> Any in
            if let url = element as? URL {
                return url.addSchemeIfNeeded()
            }
            return element
        }

        var activities = [UIActivity]()
        if needSafariActivity {
            let url = shareItem.compactMap({ $0 as? URL }).first
            activities = [SafariActivity(title: "Safariで開く", url: url)]
        }
        let activityController = UIActivityViewController(activityItems: shareItem,
                                                          applicationActivities: activities)

        // pause use
        // activityController.completionWithItemsHandler = { activityType, completed, returnedItems, error in
        //
        // }

        //         let excludeActivity = [UIActivity.ActivityType.postToTwitter]
        //         activityController.excludedActivityTypes = excludeActivity

        UIApplication.topViewController?.present(activityController, animated: true, completion: nil)
    }

}
