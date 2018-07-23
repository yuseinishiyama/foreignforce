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

    public var parameters: [String : String]?

    public init(sourceLanguage: Language = .en, query: String) {

        self.path = "search/\(sourceLanguage)"
        self.parameters = ["q" : query]
    }
}
