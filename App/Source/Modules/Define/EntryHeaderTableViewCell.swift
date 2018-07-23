//
//  EntryHeaderTableViewCell.swift
//  App
//
//  Created by Yusei Nishiyama on 23/07/2018.
//  Copyright © 2018 Yusei Nishiyama. All rights reserved.
//

import UIKit

class EntryHeaderTableViewCell: UITableViewCell {

    struct ViewModel: ViewModelProtocol {
        let word: String
        let pronunciation: String
    }

    @IBOutlet weak var wordLabel: UILabel!

    @IBOutlet weak var pronunciationLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

extension EntryHeaderTableViewCell: ViewModelConfigurable {
    func configure(viewModel: ViewModel) {
        wordLabel.text = viewModel.word
        pronunciationLabel.text = viewModel.pronunciation
    }
}
