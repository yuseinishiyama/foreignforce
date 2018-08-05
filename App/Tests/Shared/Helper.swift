//
//  Helper.swift
//  Tests
//
//  Created by Yusei Nishiyama on 05/08/2018.
//  Copyright © 2018 Yusei Nishiyama. All rights reserved.
//

import Foundation

class Helper {}

func loadFixture<T: Decodable>(_: T.Type, from file: String) -> T {
    let path = Bundle(for: Helper.self).path(forResource: file, ofType: "json")!
    let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
    let decoder = JSONDecoder()
    return try! decoder.decode(T.self, from: data)
}
