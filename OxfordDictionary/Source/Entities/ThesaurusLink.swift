//
//  ThesaurusLink.swift
//  Foreignforce
//
//  Created by Yusei Nishiyama on 21/07/2018.
//  Copyright © 2018 Yusei Nishiyama. All rights reserved.
//

import Foundation

public struct ThesaurusLink: Decodable {

    enum CodingKeys: String, CodingKey {
        case entryID = "entry_id"
        case senseID = "sense_id"
    }

    public let entryID: String
    public let senseID: String
}
