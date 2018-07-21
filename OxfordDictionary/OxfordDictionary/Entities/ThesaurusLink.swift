//
//  ThesaurusLink.swift
//  Foreignforce
//
//  Created by Yusei Nishiyama on 21/07/2018.
//  Copyright © 2018 Yusei Nishiyama. All rights reserved.
//

import Foundation

struct ThesaurusLink: Decodable {

    enum CodingKeys: String, CodingKey {
        case entryID = "entry_id"
        case senseID = "sense_id"
    }

    let entryID: String
    let senseID: String
}
