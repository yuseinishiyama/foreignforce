//
//  Sense.swift
//  Foreignforce
//
//  Created by Yusei Nishiyama on 27/05/2018.
//  Copyright © 2018 Yusei Nishiyama. All rights reserved.
//

import Foundation

struct Sense: Decodable {
    let crossReferenceMarkers: [String]?
    // let crossReferences: CrossReferencesList?
    let definitions: [String]?
    let domains: [String]?
    // let example: ExampleList?
    let id: String?
    let notes: [CategorizedText]?
    let pronunciations: [Pronunciation]?
    let regions: [String]?
    let registers: [String]?
    let shortDefinitions: [String]? // short_definitions
    let subsenses: [Sense]?
    // let thesaurusLinks: [ThesaurusLink]?
    // let translations: TranslationsList?
    // let variantForms: VariantFormsList?
}
