//
//  LexicalEntry.swift
//  Foreignforce
//
//  Created by Yusei Nishiyama on 27/05/2018.
//  Copyright © 2018 Yusei Nishiyama. All rights reserved.
//

import Foundation

public struct LexicalEntry: Decodable {
    public let derivativeOf: [RelatedEntry]?
    public let derivatives: [RelatedEntry]?
    public let entries: [Entry]?
    public let grammaticalFeatures: GrammaticalFeature?
    public let language: String
    public let lexicalCategory: String
    public let notes: [CategorizedText]?
    public let pronunciations: [Pronunciation]?
    public let text: String
    public let variantForms: [VariantForm]?
}
