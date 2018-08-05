//
//  Entry.swift
//  Foreignforce
//
//  Created by Yusei Nishiyama on 26/05/2018.
//  Copyright © 2018 Yusei Nishiyama. All rights reserved.
//

import Foundation

public struct Entry: Decodable {
    public let etymologies: [String]?
    public let grammaticalFeatures: [GrammaticalFeature]?
    public let homographNumber: String?
    public let notes: [CategorizedText]?
    public let pronunciations: [Pronunciation]?
    public let senses: [Sense]?
    public let variantForms: [VariantForm]?
}

public extension Entry {
    public var homographGroupIndex: Int? {
        guard let homographNumber = homographNumber else { return nil }
        let homographNumberDigits = homographNumber.map(String.init)
        precondition(homographNumberDigits.count == 3, "homographNumber should consist of 3 digits")
        return Int(homographNumberDigits[0])
    }
}
