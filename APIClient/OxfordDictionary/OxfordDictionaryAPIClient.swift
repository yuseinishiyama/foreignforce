//
//  APIClient.swift
//  Foreignforce
//
//  Created by Yusei Nishiyama on 20/05/2018.
//  Copyright © 2018 Yusei Nishiyama. All rights reserved.
//

import Foundation

struct OxfordDictionaryAPIClient: APIClient {
    let environment: Environment

    init(environment: Environment = OxfordDictionaryEnvironment()) {
        self.environment = environment
    }

    func request(endpoint: Endpoint) -> URLSessionTask {
        var request = endpoint.build(environment: environment)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(environment.appID, forHTTPHeaderField: "app_id")
        request.addValue(environment.appKey, forHTTPHeaderField: "app_key")

        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if let response = response, let data = data, let jsonData = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) {
                print(response)
                print(jsonData)
            } else {
                print(error ?? "")
                if let data = data {
                    print(NSString(data: data, encoding: String.Encoding.utf8.rawValue) ?? "")
                }
            }
        }
        task.resume()
        return task
    }
}
