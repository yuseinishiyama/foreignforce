//
//  LexicalEntry.swift
//  Foreignforce
//
//  Created by Yusei Nishiyama on 27/05/2018.
//  Copyright © 2018 Yusei Nishiyama. All rights reserved.
//

import Foundation

struct LexicalEntry: Decodable {
    let derivativeOf: [RelatedEntry]?
    let derivatives: [RelatedEntry]?
    let entries: [Entry]?
    let grammaticalFeatures: GrammaticalFeature?
    let language: String
    let lexicalCategory: String
    let notes: [CategorizedText]?
    let pronunciations: [Pronunciation]?
    // let text: String
    // let variantForms: VariantFormsList?
}
