//
//  RelatedEntry.swift
//  Foreignforce
//
//  Created by Yusei Nishiyama on 21/07/2018.
//  Copyright © 2018 Yusei Nishiyama. All rights reserved.
//

import Foundation

struct RelatedEntry: Decodable {
    let domains: [String]
    let id: String
    let language: String
    let regions: [String]?
    let registers: [String]?
    let text: String
}
