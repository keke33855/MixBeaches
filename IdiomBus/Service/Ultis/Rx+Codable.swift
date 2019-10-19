//
//  Rx+Codable.swift
//  NomuraDemo
//
//  Created by liofty on 2019/6/14.
//  Copyright © 2019 lio. All rights reserved.
//

import Foundation

import Moya

extension PrimitiveSequence where Trait == SingleTrait, Element == Moya.Response {
    func map<T: Decodable>(_ type: T.Type, keyPath: String? = nil) -> Single<T> {
        return flatMap({ response -> Single<T> in
            return Single<T>.just(try response.map(type, keyPath: keyPath))
        })
    }
}

extension PrimitiveSequence where Trait == SingleTrait, Element == Moya.Response {
    func filterSuccessfulResponse() -> Single<Moya.Response> {
        return flatMap {
            return Single<Moya.Response>.just(try $0.filterSuccessfulResponse())
        }
    }
}

extension ObservableType where E == Response {
    func map<T: Decodable>(_ type: T.Type, keyPath: String? = nil) -> Observable<T> {
        return flatMap({ response -> Observable<T> in
            return Observable<T>.just(try response.map(type, keyPath: keyPath))
        })
    }
}

extension PrimitiveSequence where Trait == SingleTrait, Element == Moya.Response {
    func flatMapAppError() -> Single<Element> {
        return catchError({ error -> PrimitiveSequence<Trait, Element> in
            throw AppError.make(error: error)
        })
    }
}
