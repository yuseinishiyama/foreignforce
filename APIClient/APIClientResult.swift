//
//  APIClientResult.swift
//  Foreignforce
//
//  Created by Yusei Nishiyama on 27/05/2018.
//  Copyright © 2018 Yusei Nishiyama. All rights reserved.
//

import Foundation

enum APIClientResult<T> {

    case noResponse(Error)
    case hasResponse(HTTPURLResponse, Result<T>)

    var statusCode: Int? {

        switch self {
        case .noResponse:
            return nil

        case .hasResponse(let response, _):
            return response.statusCode
        }
    }

    var result: Result<T> {

        switch (object, error) {
        case (.some(let object), .none):
            return .success(object)

        case (.none, .some(let error)):
            return .failure(error)

        default:
            fatalError()
        }
    }

    private var object: T? {

        switch self {
        case .noResponse:
            return nil

        case .hasResponse(_, let result):
            guard case let .success(object) = result else {
                return nil
            }

            return object
        }
    }

    private var error: Error? {

        switch self {
        case .noResponse(let error):
            return error

        case .hasResponse(_, let result):
            guard case let .failure(error) = result else {
                return nil
            }

            return error
        }
    }
}
