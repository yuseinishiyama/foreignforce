//
//  Endpoint.swift
//  Foreignforce
//
//  Created by Yusei Nishiyama on 20/05/2018.
//  Copyright © 2018 Yusei Nishiyama. All rights reserved.
//

import Foundation

protocol Endpoint {
    var path: String { get }
    var parameters: [String: String]? { get }

    func build(environment: Environment) -> URLRequest
}

extension Endpoint {
    var parameters: [String: String]? { return nil }

    func build(environment: Environment) -> URLRequest {
        let url = environment.baseURL.appendingPathComponent(path)
        return URLRequest(url: url)
    }
}
