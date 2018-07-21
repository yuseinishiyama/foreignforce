//
//  HeadwordEntry.swift
//  Foreignforce
//
//  Created by Yusei Nishiyama on 27/05/2018.
//  Copyright © 2018 Yusei Nishiyama. All rights reserved.
//

import Foundation

public struct HeadwordEntry: Decodable {
    public let id: String
    public let language: String
    public let lexicalEntries: [LexicalEntry]
    public let pronunciations: [Pronunciation]?
    public let type: String?
    public let word: String
}
