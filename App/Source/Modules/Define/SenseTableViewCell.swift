//
//  SenseTableViewCell.swift
//  App
//
//  Created by Yusei Nishiyama on 04/08/2018.
//  Copyright © 2018 Yusei Nishiyama. All rights reserved.
//

import UIKit

class SenseTableViewCell: UITableViewCell {

    struct ViewModel: ViewModelProtocol {
        let index: Int
        let definition: String
    }

    @IBOutlet weak var indexLabel: UILabel!

    @IBOutlet weak var definitionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension SenseTableViewCell: ViewModelConfigurable {
    func configure(viewModel: ViewModel) {
        indexLabel.text = String(viewModel.index)
        definitionLabel.text = viewModel.definition
    }
}
