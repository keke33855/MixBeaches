//
//  AppVersion.swift
//  JiPaiQi
//
//  Created by jf on 2019/9/4.
//  Copyright © 2019 lixi. All rights reserved.
//

import Foundation

struct AppVersion {
    var version: String?
    var platform: String?
    var message: String?
}

extension AppVersion: Decodable {
    enum CodingKeys: String, CodingKey {
        case version = "version"
        case platform = "platform"
        case message = "message"
    }
}
