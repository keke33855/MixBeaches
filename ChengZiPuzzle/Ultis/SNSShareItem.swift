//
//  SNSShareItem.swift
//  nomura
//
//  Created by wanglei on 2019/7/10.
//  Copyright © 2019 lio. All rights reserved.
//

import Foundation
import UIKit

enum SNSShareItem {
    case facebook(text: String, urls: [String])
    case twitter(text: String, urls: [String])
    case line(text: String, urls: [String])

    var baseHost: String {
        switch self {
        case .facebook:
            return "https://www.facebook.com/sharer/sharer.php?u="
        case .twitter:
            return "https://twitter.com/intent/tweet?text="
        case .line:
            return "https://line.me/R/msg/text/?"
        }
    }

    var shareURL: URL? {
        var allTexts = [String]()

        switch self {
        case .facebook(_, let urls):
            allTexts = urls
        case let .twitter(text, urls),
             let .line(text, urls):
            allTexts = urls
            allTexts.insert(text, at: 0)
        }

        allTexts = allTexts.filter { !$0.isEmpty }

        guard allTexts.count > 0,
            let shareText = allTexts.joined(separator: "\n")
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let url = URL(string: baseHost + shareText) else {
                return nil
        }

        return url
    }
}

extension BaseViewController {
    func share(item: SNSShareItem) {
        guard let url = item.shareURL else { return }
        openURL(url)
    }
}
