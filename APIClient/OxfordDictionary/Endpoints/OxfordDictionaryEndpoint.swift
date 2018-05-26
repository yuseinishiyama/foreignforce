//
//  OxfordDictionaryEndpoint.swift
//  Foreignforce
//
//  Created by Yusei Nishiyama on 27/05/2018.
//  Copyright © 2018 Yusei Nishiyama. All rights reserved.
//

import Foundation

protocol OxfordDictionaryEndpoint: Endpoint {}

extension OxfordDictionaryEndpoint {

    func parseError(response: HTTPURLResponse, data: Data?) throws -> OxfordDictionaryError {

        guard let data = data else {
            throw APIClientError.noData
        }

        guard let reason = String(data: data, encoding: String.Encoding.utf8) else {
            throw APIClientError.invalidData(data)
        }

        return OxfordDictionaryError(reason: reason)
    }
}
