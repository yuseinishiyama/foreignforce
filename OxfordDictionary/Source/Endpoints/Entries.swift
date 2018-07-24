//
//  Entries.swift
//  OxfordDictionary
//
//  Created by Yusei Nishiyama on 23/07/2018.
//  Copyright © 2018 Yusei Nishiyama. All rights reserved.
//

import Foundation

public struct Entries: Endpoint {

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
