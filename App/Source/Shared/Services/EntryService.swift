//
//  EntryService.swift
//  App
//
//  Created by Yusei Nishiyama on 24/07/2018.
//  Copyright © 2018 Yusei Nishiyama. All rights reserved.
//

import Foundation
import APIClient
import OxfordDictionary

class EntryService: Service {

    func headwordEntry(wordID: String, completion: @escaping (Result<HeadwordEntry, APIClient.Error>) -> ()) {
        let entries = Entries(wordID: wordID)
        let apiClient = OxfordDictionaryClient(environment: Environment())
        apiClient.request(endpoint: entries) { result in
            switch result {
            case let .success(retrieveEntry):
                let headwordEntry = RetrieveEntryEntryParser.parse(retrieveEntry)
                completion(.success(headwordEntry))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
