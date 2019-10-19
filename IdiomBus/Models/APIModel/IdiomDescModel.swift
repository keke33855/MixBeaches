//
//  IdiomDescModel.swift
//  idiom
//
//  Created by jf on 2019/9/26.
//  Copyright © 2019 chang. All rights reserved.
//

import Foundation

struct IdiomDescModel {
    var name: String?
    var pronounce: String?
    var content: String?
    var comefrom: String?
    var antonym: [String]?
    var thesaurus: [String]?
    var example: String?
}

//extension IdiomDescModel: Decodable {
//    enum CodingKeys: String, CodingKey {
//        case name = "name"
//        case pronounce = "pronounce"
//        case content = "content"
//        case comefrom = "comefrom"
//        case antonym = "antonym"
//        case thesaurus = "thesaurus"
//        case example = "example"
//    }
//}

extension IdiomDescModel: Mappable {
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        name <- map["name"]
        pronounce <- map["pronounce"]
        content <- map["content"]
        comefrom <- map["comefrom"]
        antonym <- map["antonym"]
        thesaurus <- map["thesaurus"]
        example <- map["example"]
    }
}
