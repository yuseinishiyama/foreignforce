//
//  APIClient.swift
//  Foreignforce
//
//  Created by Yusei Nishiyama on 20/05/2018.
//  Copyright © 2018 Yusei Nishiyama. All rights reserved.
//

import Foundation

protocol APIClient {
    var environment: Environment { get }

    func request(endpoint: Endpoint) -> URLSessionTask
}
