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

    var words: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.registerNib(SearchResultTableViewCell.self)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SearchResultTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.wordLabel.text = words[indexPath.row]

        return cell
    }
}
