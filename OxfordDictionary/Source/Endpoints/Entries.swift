//
//  Entries.swift
//  Foreignforce
//
//  Created by Yusei Nishiyama on 20/05/2018.
//  Copyright © 2018 Yusei Nishiyama. All rights reserved.
//

import Foundation

public struct Entries: OxfordDictionaryEndpoint {

    public typealias Response = RetrieveEntry

    public let path: String

    public init(sourceLanguage: Language = .en, wordID: String, region: Region? = nil, filters: [String]? = nil) {

        var path = "entries/\(sourceLanguage)/\(wordID)"

        if let region = region {
            path.append("/regions=\(region.rawValue)")
        }

        if let _ = filters {
            fatalError("filter is not supported yet")
        }

        self.path = path
    }
}
