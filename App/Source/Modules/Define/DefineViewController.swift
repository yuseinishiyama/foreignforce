//
//  DefineViewController.swift
//  App
//
//  Created by Yusei Nishiyama on 23/07/2018.
//  Copyright © 2018 Yusei Nishiyama. All rights reserved.
//

import UIKit
import OxfordDictionary

import APIClient

class DefineViewController: UITableViewController {

    var wordID: String! = "ace"

    private var headwordEntry: [HeadwordEntry] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        clearsSelectionOnViewWillAppear = false

        EntryService().headwordEntry { result in

            switch result {
            case let .success(entry):
                print(entry)
            case let .failure(error):
                print(error)
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return headwordEntry.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: EntryHeaderTableViewCell = tableView.dequeueReusableCell(for: indexPath)
//        let word = headwordEntry[0].word
//        let pronunciation = headwordEntry[0].pronunciations?[0].phoneticSpelling ?? ""
//        let viewModel = EntryHeaderTableViewCell.ViewModel(word: word, pronunciation: pronunciation)
//        cell.configure(viewModel: viewModel)

        return cell
    }
}
