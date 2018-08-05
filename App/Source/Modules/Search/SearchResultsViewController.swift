//
//  SearchResultsViewController.swift
//  Foreignforce
//
//  Created by Yusei Nishiyama on 27/05/2018.
//  Copyright © 2018 Yusei Nishiyama. All rights reserved.
//

import Foundation
import UIKit

class SearchResultsTableViewController: UITableViewController {

    struct ViewModel: ViewModelProtocol {
        let words: [String]
    }

    private var viewModel = ViewModel(words: [])

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.registerNib(SearchResultTableViewCell.self)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.words.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SearchResultTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.wordLabel.text = viewModel.words[indexPath.row]

        return cell
    }
}

extension SearchResultsTableViewController: ViewModelConfigurable {
    func configure(viewModel: SearchResultsTableViewController.ViewModel) {
        self.viewModel = viewModel
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
