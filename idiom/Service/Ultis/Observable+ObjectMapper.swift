//
//  Observable+ObjectMapper.swift
//  Renosys
//
//  Created by jf on 2018/6/15.
//  Copyright © 2018年 liofty. All rights reserved.
//

import Foundation
import RxSwift
import ObjectMapper
import Moya

public extension PrimitiveSequence where TraitType == SingleTrait, Element == Response {
    func mapObject<T: Mappable>(_ type: T.Type) -> Single<T> {
        return flatMap({ (response) -> Single<T> in
            return Single.just(try response.mapObject())
        })
    }

    func mapArray<T: Mappable>(_ type: T.Type) -> Single<[T]> {
        return flatMap({ (response) -> Single<[T]> in
            return Single.just(try response.mapArray())
        })
    }

    // get the sub response
    func mapResponse(key: String) -> Single<E> {
        return map({ (res) -> E in
            let dic = try JSONSerialization.jsonObject(with: res.data, options: .allowFragments) as? [String: Any]
            let newDic = dic?[key]
            let data = try JSONSerialization.data(withJSONObject: newDic ?? [], options: .prettyPrinted)
            return Response(statusCode: res.statusCode, data: data)
        })
    }
}

public extension ObservableType where E == Response {

    func mapObject<T: Mappable>(_ type: T.Type) -> Observable<T> {
        return flatMap { response -> Observable<T> in
            return Observable.just(try response.mapObject())
        }
    }

    func mapArray<T: Mappable>(_ type: T.Type) -> Observable<[T]> {
        return flatMap { response -> Observable<[T]> in
            return Observable.just(try response.mapArray())
        }
    }

    func mapResponse(key: String) -> Observable<E> {
        return map({ (res) -> E in
            let dic = try JSONSerialization.jsonObject(with: res.data, options: .allowFragments) as? [String: Any]
            let newDic = dic?[key]
            let data = try JSONSerialization.data(withJSONObject: newDic ?? [], options: .prettyPrinted)
            return Response(statusCode: res.statusCode, data: data)
        })
    }
}
