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
    // let grammaticalFeatures: GrammaticalFeaturesList?
    let homographNumber: String?
    // let notes: CategorizedTextList?
    // let pronunciations: PronunciationsList?
    let senses: [Sense]?
    // let variantForms: VariantFormsList?
}
