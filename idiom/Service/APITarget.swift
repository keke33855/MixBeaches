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
    
    case searchIdiom(String)
    case idiomDescription(String)
}

extension APITarget: TargetType {
    var baseURL: URL {
        var urlString: String
        switch self {
        case .appVersion:
            urlString = "https://www.ky55667788.com"
        case .searchIdiom, .idiomDescription:
            urlString = "https://api.jisuapi.com"
        }
        
        guard let url = URL(string: urlString) else {
            fatalError()
        }
        return url
    }

    var path: String {
        switch self {
        case .searchIdiom:
            return "/chengyu/search"
        case .idiomDescription:
            return "/chengyu/detail"
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
        case .searchIdiom(let keyword):
            parameters["appkey"] = "e3a803eb7734d0b6"
            parameters["keyword"] =  keyword
        case .idiomDescription(let idiom):
            parameters["appkey"] = "e3a803eb7734d0b6"
            parameters["chengyu"] =  idiom
        case .appVersion:
            parameters["id"] = "idiom"
        }
        
        return Task.requestParameters(parameters: parameters,
                                      encoding: URLEncoding.default)
    }

    var headers: [String: String]? {
        return nil
    }
}
