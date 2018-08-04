//
//  LexicalEntryHeaderTableViewCell.swift
//  App
//
//  Created by Yusei Nishiyama on 04/08/2018.
//  Copyright © 2018 Yusei Nishiyama. All rights reserved.
//

import UIKit

class LexicalEntryHeaderTableViewCell: UITableViewCell {

    struct ViewModel: ViewModelProtocol {
        let lexicalCategory: String
    }

    @IBOutlet weak var lexicalCategoryLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension LexicalEntryHeaderTableViewCell: ViewModelConfigurable {
    func configure(viewModel: ViewModel) {
        lexicalCategoryLabel.text = viewModel.lexicalCategory
    }
}
