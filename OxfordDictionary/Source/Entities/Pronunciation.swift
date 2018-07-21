//
//  Pronunciation.swift
//  Foreignforce
//
//  Created by Yusei Nishiyama on 21/07/2018.
//  Copyright © 2018 Yusei Nishiyama. All rights reserved.
//

import Foundation

public struct Pronunciation: Decodable {
    public let audioFile: String?
    public let dialects: [String]?
    public let phoneticNotation: String?
    public let phoneticSpelling: String?
    public let regions: [String]?
}
