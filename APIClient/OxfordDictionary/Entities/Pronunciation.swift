//
//  Pronunciation.swift
//  Foreignforce
//
//  Created by Yusei Nishiyama on 21/07/2018.
//  Copyright © 2018 Yusei Nishiyama. All rights reserved.
//

import Foundation

struct Pronunciation: Decodable {
    let audioFile: String?
    let dialects: [String]?
    let phoneticNotation: String?
    let phoneticSpelling: String?
    let regions: [String]?
}
