//
//  OxfordDictionaryEndpoint.swift
//  Foreignforce
//
//  Created by Yusei Nishiyama on 27/05/2018.
//  Copyright © 2018 Yusei Nishiyama. All rights reserved.
//

import Foundation
import APIClient

public protocol Endpoint: APIClient.Endpoint {}

public extension Endpoint {

    public func parseError(response: HTTPURLResponse, data: Data?) throws -> Error {

        guard let data = data else {
            throw APIClient.Error.decodeError(nil)
        }

        guard let reason = String(data: data, encoding: String.Encoding.utf8) else {
            throw APIClient.Error.decodeError(nil)
        }

        return Error(reason: reason)
    }
}
