//
//  OxfordDictionaryEnvironment.swift
//  Foreignforce
//
//  Created by Yusei Nishiyama on 20/05/2018.
//  Copyright © 2018 Yusei Nishiyama. All rights reserved.
//

import Foundation
import APIClient

struct OxfordDictionaryEnvironment: Environment {

    let apiVersion = "v1"

    var baseURL: URL {
        guard let url = URL(string: "https://od-api.oxforddictionaries.com/api")?.appendingPathComponent(apiVersion) else {
            fatalError("Invalid base URL")
        }
        return url
    }

    let appID: String = "60dfd7a1"

    let appKey: String = {
        guard let appKey = Bundle.main.object(forInfoDictionaryKey: "Oxford API Application Key") as? String, !appKey.isEmpty else {
            fatalError("No API key found")
        }
        return appKey
    }()
}
