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

    func headwordEntry(completion: (Result<HeadwordEntry, APIClient.Error>) -> ()) {

//        let entries = Entries(wordID: wordID)
//        let apiClient = OxfordDictionaryClient(environment: Environment())
//        apiClient.request(endpoint: entries) { result in
//            switch result {
//            case let .success(retrieveEntry):
//                self.headwordEntry = retrieveEntry.results ?? []
//            case let .failure(error):
//                print(error)
//            }
//        }

//        let parsedHeadwordEntry = RetrieveEntryEntryParser.parse(retriveEntry)
//        completion(.success(parsedHeadwordEntry))
    }
}
