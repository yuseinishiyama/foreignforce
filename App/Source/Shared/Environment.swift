//
//  OxfordDictionaryEnvironment.swift
//  App
//
//  Created by Yusei Nishiyama on 22/07/2018.
//  Copyright © 2018 Yusei Nishiyama. All rights reserved.
//

import Foundation
import OxfordDictionary

struct Environment {}

extension Environment: OxfordDictionary.Environment {
    public var appID: String { return "60dfd7a1" }

    public var appKey: String {
        guard let appKey = Bundle.main.object(forInfoDictionaryKey: "Oxford API Application Key") as? String, !appKey.isEmpty else {
            fatalError("No API key found")
        }
        return appKey
    }
}
