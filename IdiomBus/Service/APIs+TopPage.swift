//
//  APIs+TopPage.swift
//  JiPaiQi
//
//  Created by jf on 2019/9/4.
//  Copyright © 2019 lixi. All rights reserved.
//

import Foundation
import RxSwift

extension APIs {
    func requestAppVersion() -> Single<AppVersion> {
        return request(target: APITarget.appVersion, element: AppVersion.self)
    }
}
