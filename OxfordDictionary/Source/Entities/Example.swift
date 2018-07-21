//
//  Example.swift
//  Foreignforce
//
//  Created by Yusei Nishiyama on 21/07/2018.
//  Copyright © 2018 Yusei Nishiyama. All rights reserved.
//

import Foundation

public struct Example: Decodable {

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

    public let definitions: [String]?
    public let domains: [String]?
    public let notes: [CategorizedText]?
    public let regions: [String]?
    public let registers: [String]?
    public let senseIDs: [String]?
    public let text: String
    public let translations: [Translation]?
}
