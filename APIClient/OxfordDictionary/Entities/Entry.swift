//
//  Entry.swift
//  Foreignforce
//
//  Created by Yusei Nishiyama on 26/05/2018.
//  Copyright © 2018 Yusei Nishiyama. All rights reserved.
//

import Foundation

struct Entry: Decodable {
    let etymologies: [String]?
    let grammaticalFeatures: [GrammaticalFeature]?
    let homographNumber: String?
    let notes: [CategorizedText]?
    let pronunciations: [Pronunciation]?
    let senses: [Sense]?
    let variantForms: [VariantForm]?
}
