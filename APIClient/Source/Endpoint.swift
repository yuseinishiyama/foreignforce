//
//  Endpoint.swift
//  Foreignforce
//
//  Created by Yusei Nishiyama on 20/05/2018.
//  Copyright © 2018 Yusei Nishiyama. All rights reserved.
//

import Foundation

public enum ParameterEncoding {
    case url
}

public protocol Endpoint {

    associatedtype Response: Decodable
    associatedtype ErrorObject: Swift.Error

    var path: String { get }
    var parameters: [String: String] { get }
    var parameterEncoding: ParameterEncoding { get }

    func build(environment: Environment) -> URLRequest
    func parse(response: HTTPURLResponse, data: Data?) throws -> Response
    func parseError(response: HTTPURLResponse, data: Data?) throws -> ErrorObject
}

public extension Endpoint {

    var parameters: [String: String] { return [:] }

    var parameterEncoding: ParameterEncoding { return .url }

    func build(environment: Environment) -> URLRequest {

        let url = environment.baseURL.appendingPathComponent(path)
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)

        switch parameterEncoding {
        case .url:
            let parameters = self.parameters.map(URLQueryItem.init)
            urlComponents?.queryItems = parameters
        }

        guard let urlWithQuery = urlComponents?.url else {
            fatalError("Invalid URL")
        }

        return URLRequest(url: urlWithQuery)
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
