//
//  Result.swift
//  Foreignforce
//
//  Created by Yusei Nishiyama on 26/05/2018.
//  Copyright © 2018 Yusei Nishiyama. All rights reserved.
//

import Foundation

public enum Result<T, E: Swift.Error> {

    case success(T)
    case failure(E)
}
