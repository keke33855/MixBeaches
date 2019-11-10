//
//  Moya+ObjectMapper.swift
//  Renosys
//
//  Created by wanglei on 2018/6/15.
//  Copyright © 2018年 liofty. All rights reserved.
//

import RxSwift
import Moya
import ObjectMapper

extension Response {
    func mapObject<T: Mappable>() throws -> T {
        guard let object = Mapper<T>().map(JSONObject: try mapJSON()) else {
            throw MoyaError.jsonMapping(self)
        }
        return object
    }

    func mapArray<T: Mappable>() throws -> [T] {
        guard let object = Mapper<T>().mapArray(JSONObject: try mapJSON()) else {
            throw MoyaError.jsonMapping(self)
        }
        return object
    }
}
