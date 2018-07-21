//
//  HeadwordEntry.swift
//  Foreignforce
//
//  Created by Yusei Nishiyama on 27/05/2018.
//  Copyright © 2018 Yusei Nishiyama. All rights reserved.
//

import Foundation

struct HeadwordEntry: Decodable {
    let id: String
    let language: String
    let lexicalEntries: [LexicalEntry]
    let pronunciations: [Pronunciation]?
    let type: String?
    let word: String
}
