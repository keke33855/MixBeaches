//
//  SearchResultModel.swift
//  idiom
//
//  Created by jf on 2019/9/26.
//  Copyright © 2019 chang. All rights reserved.
//

import Foundation

struct SearchResultModel {
    var status: String?
    var msg: String?
    var result: [IdiomResult]?
}

extension SearchResultModel: Mappable {
    init?(map: Map) {}

    mutating func mapping(map: Map) {
        status <- map["status"]
        msg <- map["msg"]
        result <- map["result"]
    }
}

//extension SearchResultModel: Decodable {
//    enum CodingKeys: String, CodingKey {
//        case status = "status"
//        case msg = "msg"
//        case result = "result"
//    }
//}

struct IdiomResult {
    var name: String?
}

//extension IdiomResult: Decodable {
//    enum CodingKeys: String, CodingKey {
//        case name = "name"
//    }
//}

extension IdiomResult: Mappable {
    init?(map: Map) {}

    mutating func mapping(map: Map) {
        name <- map["name"]
    }
}
