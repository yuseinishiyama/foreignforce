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

    @discardableResult
    func request<T: Endpoint>(endpoint: T, completion: @escaping (APIClientResult<T.Response>) -> ()) -> URLSessionTask {

        var request = endpoint.build(environment: environment)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(environment.appID, forHTTPHeaderField: "app_id")
        request.addValue(environment.appKey, forHTTPHeaderField: "app_key")

        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in

            guard let response = response as? HTTPURLResponse else {
                if let error = error {
                    completion(.noResponse(error))
                } else {
                    completion(.noResponse(APIClientError.unknown))
                }
                return
            }

            switch (response.statusCode, data, error) {
            case (..<400, data, .none):
                do {
                    let object = try endpoint.parse(response: response, data: data)
                    completion(.hasResponse(response, .success(object)))
                } catch {
                    completion(.hasResponse(response, .failure(error)))
                }

            case (400..., data, .none):
                do {
                    let object = try endpoint.parseError(response: response, data: data)
                    completion(.hasResponse(response, .failure(APIClientError.apiError(object))))
                } catch {
                    completion(.hasResponse(response, .failure(error)))
                }

            default:
                completion(.hasResponse(response, .failure(APIClientError.unknown)))
            }
        }

        task.resume()
        return task
    }
}
