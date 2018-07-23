//
//  ViewModel.swift
//  App
//
//  Created by Yusei Nishiyama on 23/07/2018.
//  Copyright © 2018 Yusei Nishiyama. All rights reserved.
//

import Foundation

protocol ViewModelProtocol {}

protocol ViewModelConfigurable: class {
    associatedtype ViewModel: ViewModelProtocol

    func configure(viewModel: ViewModel)
}
