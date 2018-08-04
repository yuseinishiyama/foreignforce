//
//  SubsenseTableViewCell.swift
//  App
//
//  Created by Yusei Nishiyama on 04/08/2018.
//  Copyright © 2018 Yusei Nishiyama. All rights reserved.
//

import UIKit

class SubsenseTableViewCell: UITableViewCell {

    struct ViewModel: ViewModelProtocol {
        let definition: String
    }

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

extension SubsenseTableViewCell: ViewModelConfigurable {
    func configure(viewModel: ViewModel) {
        definitionLabel.text = viewModel.definition
    }
}
