//
//  OxfordDictionaryAPIError.swift
//  Foreignforce
//
//  Created by Yusei Nishiyama on 26/05/2018.
//  Copyright © 2018 Yusei Nishiyama. All rights reserved.
//

import Foundation

public enum Error: Swift.Error {

    case unknown
    case apiError(Swift.Error)
    case networkError(Swift.Error)
    case decodeError(Swift.Error?)
}
