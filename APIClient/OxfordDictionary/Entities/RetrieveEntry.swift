//
//  RetrieveEntry.swift
//  Foreignforce
//
//  Created by Yusei Nishiyama on 27/05/2018.
//  Copyright © 2018 Yusei Nishiyama. All rights reserved.
//

import Foundation

struct RetrieveEntry: Decodable {
    let metadata: Metadata?
    let results: [HeadwordEntry]?
}
