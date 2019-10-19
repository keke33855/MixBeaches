//
//  FinancialInstrumentType.swift
//  nomura
//
//  Created by liofty on 2019/7/25.
//  Copyright © 2019 lio. All rights reserved.
//

import Foundation

enum FinancialInstrumentType: String {
    case jaStock = "jp-stock"                   // 国内株式
    case jaIndex = "jp-index"                   // 国内指標
    case usIndex = "us-index"                   // 米国指標(主要3指標のみ)
    case asiaIndex = "asia-index"               // アジア指標
    case hkIndex = "hk-index"                   // 香港指標
    case globalIndex = "global-index"           // その他海外指標
    case exchange = "exchange"                  // 為替
    case none

    static func make(val: String?) -> FinancialInstrumentType {
        guard let val = val else { return .none }
        return FinancialInstrumentType(rawValue: val) ?? .none
    }
}
