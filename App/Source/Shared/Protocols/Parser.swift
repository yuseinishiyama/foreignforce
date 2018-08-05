//
//  Parser.swift
//  App
//
//  Created by Yusei Nishiyama on 05/08/2018.
//  Copyright © 2018 Yusei Nishiyama. All rights reserved.
//

import Foundation

protocol Parser {
    associatedtype From
    associatedtype To

    static func parse(_: From) -> To
}
