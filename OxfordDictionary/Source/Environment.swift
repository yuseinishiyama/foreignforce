//
//  OxfordDictionaryEnvironment.swift
//  Foreignforce
//
//  Created by Yusei Nishiyama on 20/05/2018.
//  Copyright © 2018 Yusei Nishiyama. All rights reserved.
//

import Foundation
import APIClient

public protocol Environment: APIClient.Environment {}

public extension Environment {

    public var apiVersion: String { return "v1" }

    public var baseURL: URL {
        guard let url = URL(string: "https://od-api.oxforddictionaries.com/api")?.appendingPathComponent(apiVersion) else {
            fatalError("Invalid base URL")
        }
        return url
    }
}
