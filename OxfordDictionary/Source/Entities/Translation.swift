//
//  Translation.swift
//  Foreignforce
//
//  Created by Yusei Nishiyama on 21/07/2018.
//  Copyright © 2018 Yusei Nishiyama. All rights reserved.
//

import Foundation

public struct Translation: Decodable {
    public let domains: [String]?
    public let grammaticalFeatures: [GrammaticalFeature]?
    public let language: String
    public let notes: [CategorizedText]?
    public let regions: [String]?
    public let registers: [String]?
    public let text: String
}
