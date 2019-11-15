//
//  QuickAPITarget.swift
//  nomura
//
//  Created by liofty on 2019/6/17.
//  Copyright © 2019 lio. All rights reserved.
//

import Foundation
import Moya

enum APITarget {
    case appVersion
}

extension APITarget: TargetType {
    var baseURL: URL {
        var urlString: String
        switch self {
        case .appVersion:
            urlString = "https://www.ky55667788.com"
        }
        
        guard let url = URL(string: urlString) else {
            fatalError()
        }
        return url
    }

    var path: String {
        switch self {
        case .appVersion:
            return "/ios/appVersion.json"
        }
    }

    var method: Moya.Method {
        return .get
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        var parameters: [String: Any] = [:]
        
        switch self {
        case .appVersion:
            parameters["id"] = "ChengZiPuzzle"
        }
        
        return Task.requestParameters(parameters: parameters,
                                      encoding: URLEncoding.default)
    }

    var headers: [String: String]? {
        return nil
    }
}
