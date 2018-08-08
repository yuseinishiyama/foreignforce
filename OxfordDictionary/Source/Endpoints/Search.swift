//
//  Search.swift
//  Foreignforce
//
//  Created by Yusei Nishiyama on 20/05/2018.
//  Copyright © 2018 Yusei Nishiyama. All rights reserved.
//

import Foundation

public struct Search: Endpoint {

    public typealias Response = WordList

    public let path: String

    public var parameters: [String : String]

    public init(sourceLanguage: Language = .en, query: String) {

        self.path = "search/\(sourceLanguage)"
        // If query consists of multiple words disable prefix search
        //  e.g. take out -> take something out
        let prefix = (query.split(separator: " ").count > 1) ? "false" : "true"
        self.parameters = ["q" : query, "prefix": prefix]
    }
}
