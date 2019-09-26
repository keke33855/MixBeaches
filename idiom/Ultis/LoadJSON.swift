//
//  LoadJSON.swift
//  nomura
//
//  Created by lio on 2019/7/21.
//  Copyright © 2019 lio. All rights reserved.
//

import Foundation

struct LoadJSON {

    enum FileName: String {
        case newsList = "news_list_mock.json"
        case newsDetailMeigara = "news_detail_meigara_mock.json"
        case bussinessTop = "bussiness_top_item_sample_data.json"
        case reportList = "report_list_mock.json"
        case myNews = "mypage_mynews_mock.json"
    }

    static func load<Element: Decodable>(type: Element.Type, filename: FileName, bundle: Bundle = Bundle.main) -> Element? {

        return load(type: type, filename: filename.rawValue, bundle: bundle)
    }

    static func load<Element: Decodable>(type: Element.Type, filename: String, bundle: Bundle = Bundle.main) -> Element? {
        do {
            if let url = bundle.url(forAuxiliaryExecutable: filename) {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let element = try decoder.decode(type, from: data)
                return element
            }
            print("[LoadJSON Parser Error] : Not Found JSON File -> \(filename)")
            return nil
        } catch {
            print("[LoadJSON Parser Error] : \(error)")
            return nil
        }
    }
}
