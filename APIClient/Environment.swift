//
//  Environment.swift
//  Foreignforce
//
//  Created by Yusei Nishiyama on 20/05/2018.
//  Copyright © 2018 Yusei Nishiyama. All rights reserved.
//

import Foundation

protocol Environment {
    var baseURL: URL { get }
    var apiVersion: String { get }
    var appID: String { get }
    var appKey: String { get }
}
