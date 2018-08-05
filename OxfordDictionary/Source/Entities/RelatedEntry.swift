//
//  RelatedEntry.swift
//  Foreignforce
//
//  Created by Yusei Nishiyama on 21/07/2018.
//  Copyright © 2018 Yusei Nishiyama. All rights reserved.
//

import Foundation

public struct RelatedEntry: Decodable {
    public let domains: [String]?
    public let id: String
    public let language: String?
    public let regions: [String]?
    public let registers: [String]?
    public let text: String
}
