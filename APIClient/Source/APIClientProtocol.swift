//
//  APIClient.swift
//  Foreignforce
//
//  Created by Yusei Nishiyama on 20/05/2018.
//  Copyright © 2018 Yusei Nishiyama. All rights reserved.
//

import Foundation

public protocol APIClientProtocol { // Name it protocol to avoid naming conflict with module

    var environment: Environment { get }

    func request<T: Endpoint>(endpoint: T, session: URLSession, completion: @escaping (Result<T.Response, Error>) -> ()) -> URLSessionTask
}
