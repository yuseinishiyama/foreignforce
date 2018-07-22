//
//  Endpoint.swift
//  Foreignforce
//
//  Created by Yusei Nishiyama on 20/05/2018.
//  Copyright © 2018 Yusei Nishiyama. All rights reserved.
//

import Foundation

public protocol Endpoint {

    associatedtype Response: Decodable
    associatedtype ErrorObject: Swift.Error

    var path: String { get }
    var parameters: [String: String]? { get }

    func build(environment: Environment) -> URLRequest
    func parse(response: HTTPURLResponse, data: Data?) throws -> Response
    func parseError(response: HTTPURLResponse, data: Data?) throws -> ErrorObject
}

public extension Endpoint {

    var parameters: [String: String]? { return nil }

    func build(environment: Environment) -> URLRequest {

        let url = environment.baseURL.appendingPathComponent(path)
        return URLRequest(url: url)
    }

    func parse(response: HTTPURLResponse, data: Data?) throws -> Response {

        guard let data = data else {
            throw Error.decodeError(nil)
        }

        let decoder = JSONDecoder()
        return try decoder.decode(Response.self, from: data)
    }
}

public extension Endpoint where Response == Empty {

    func parse(response: HTTPURLResponse, data: Data?) throws -> Response {
        return Empty()
    }
}
