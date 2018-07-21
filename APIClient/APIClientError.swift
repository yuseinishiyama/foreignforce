//
//  OxfordDictionaryAPIError.swift
//  Foreignforce
//
//  Created by Yusei Nishiyama on 26/05/2018.
//  Copyright © 2018 Yusei Nishiyama. All rights reserved.
//

import Foundation

enum APIClientError: Error {

    case unknown
    case apiError(Error)
    case networkError(Error)
    case decodeError(Error?)
}
