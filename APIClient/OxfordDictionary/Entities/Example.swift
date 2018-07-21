//
//  Example.swift
//  Foreignforce
//
//  Created by Yusei Nishiyama on 21/07/2018.
//  Copyright © 2018 Yusei Nishiyama. All rights reserved.
//

import Foundation

struct Example: Decodable {

    enum CodingKeys: String, CodingKey {
        case definitions
        case domains
        case notes
        case regions
        case registers
        case senseIDs = "senseIds"
        case text
        case translations
    }

    let definitions: [String]?
    let domains: [String]?
    let notes: [CategorizedText]?
    let regions: [String]?
    let registers: [String]?
    let senseIDs: [String]?
    let text: String
    let translations: [Translation]?
}
