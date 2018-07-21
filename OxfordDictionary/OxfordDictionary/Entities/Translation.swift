//
//  Translation.swift
//  Foreignforce
//
//  Created by Yusei Nishiyama on 21/07/2018.
//  Copyright © 2018 Yusei Nishiyama. All rights reserved.
//

import Foundation

struct Translation: Decodable {
    let domains: [String]?
    let grammaticalFeatures: [GrammaticalFeature]?
    let language: String
    let notes: [CategorizedText]?
    let regions: [String]?
    let registers: [String]?
    let text: String
}
