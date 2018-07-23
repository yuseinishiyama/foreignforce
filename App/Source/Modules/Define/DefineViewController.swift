//
//  DefineViewController.swift
//  App
//
//  Created by Yusei Nishiyama on 23/07/2018.
//  Copyright © 2018 Yusei Nishiyama. All rights reserved.
//

import UIKit
import OxfordDictionary

class DefineViewController: UITableViewController {

    var query: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        clearsSelectionOnViewWillAppear = false

        let entries = Entries(wordID: query)
        let apiClient = OxfordDictionaryClient(environment: Environment())
        apiClient.request(endpoint: entries) { result in
            switch result {
            case let .success(retrieveEntry):
                let words = retrieveEntry.results?.map { $0.word } ?? []

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
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: EntryHeaderTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        let viewModel = EntryHeaderTableViewCell.ViewModel(word: "word", pronunciation: "pronunciation")
        cell.configure(viewModel: viewModel)

        return cell
    }
}
