//
//  Sense.swift
//  Foreignforce
//
//  Created by Yusei Nishiyama on 27/05/2018.
//  Copyright © 2018 Yusei Nishiyama. All rights reserved.
//

import Foundation

public struct Sense: Decodable {

    enum CodingKeys: String, CodingKey {
        case crossReferenceMarkers
        case crossReferences
        case definitions
        case domains
        case example
        case id
        case notes
        case pronunciations
        case regions
        case registers
        case shortDefinitions = "short_definition"
        case subsenses
        case thesaurusLinks
        case translations
        case variantForms
    }

    public let crossReferenceMarkers: [String]?
    public let crossReferences: [CrossReference]?
    public let definitions: [String]?
    public let domains: [String]?
    public let example: [Example]?
    public let id: String?
    public let notes: [CategorizedText]?
    public let pronunciations: [Pronunciation]?
    public let regions: [String]?
    public let registers: [String]?
    public let shortDefinitions: [String]?
    public let subsenses: [Sense]?
    public let thesaurusLinks: [ThesaurusLink]?
    public let translations: [Translation]?
    public let variantForms: [VariantForm]?
}
