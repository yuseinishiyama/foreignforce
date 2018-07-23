//
//  DefineViewController.swift
//  App
//
//  Created by Yusei Nishiyama on 23/07/2018.
//  Copyright © 2018 Yusei Nishiyama. All rights reserved.
//

import UIKit

class DefineViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        clearsSelectionOnViewWillAppear = false
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: EntryHeaderTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        let viewModel = EntryHeaderTableViewCell.ViewModel(word: "word", pronunciation: "pronunciation")
        cell.configure(viewModel: viewModel)

        return cell
    }
}
