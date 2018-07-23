//
//  WordList.swift
//  OxfordDictionary
//
//  Created by Yusei Nishiyama on 23/07/2018.
//  Copyright © 2018 Yusei Nishiyama. All rights reserved.
//

import Foundation

public struct WordList: Decodable {
    public let metadata: Metadata?
    public let results: [FoundWord]?
}
