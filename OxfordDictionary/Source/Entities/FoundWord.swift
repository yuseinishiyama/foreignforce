//
//  FoundWord.swift
//  OxfordDictionary
//
//  Created by Yusei Nishiyama on 23/07/2018.
//  Copyright © 2018 Yusei Nishiyama. All rights reserved.
//

import Foundation

public struct FoundWord: Decodable {
    public let id: String
    public let matchString: String?
    public let matchType: String?
    public let region: String?
    public let word: String
}
