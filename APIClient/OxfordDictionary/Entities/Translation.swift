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

/*
 domains (arrayofstrings, optional): A subject, discipline, or branch of knowledge particular to the translation ,
 grammaticalFeatures (GrammaticalFeaturesList, optional),
 language (string): IANA language code specifying the language of the translation ,
 notes (CategorizedTextList, optional),
 regions (arrayofstrings, optional): A particular area in which the translation occurs, e.g. 'Great Britain' ,
 registers (arrayofstrings, optional): A level of language usage, typically with respect to formality. e.g. 'offensive', 'informal' ,
 text (string)
 */
