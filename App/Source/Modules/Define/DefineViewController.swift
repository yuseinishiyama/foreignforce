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

    enum ViewModel: ViewModelProtocol {

        enum Row {
            case homographHeader(HomographHeaderTableViewCell.ViewModel)
            case lexicalEntryHeader(LexicalEntryHeaderTableViewCell.ViewModel)
            case sense(SenseTableViewCell.ViewModel)
            case subsense(SubsenseTableViewCell.ViewModel)
        }

        case loading
        case loaded([Row])
    }

    var viewModel: ViewModel = .loading {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    var wordID: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        clearsSelectionOnViewWillAppear = false

        EntryService().headwordEntry(wordID: wordID) { result in

            switch result {
            case let .success(entry):

                // Parse Model into ViewModel
                var sections = [ViewModel.Row]()

                for homograph in entry.homographs {
                    sections.append(.homographHeader(.init(word: homograph.word, pronunciation: homograph.pronunciation)))

                    for lexicalEntry in homograph.lexicalEntries {
                        sections.append(.lexicalEntryHeader(.init(lexicalCategory: lexicalEntry.lexicalCategory)))

                        for (index, sense) in lexicalEntry.senses.enumerated() {
                            sections.append(.sense(.init(index: index+1, definition: sense.definition)))

                            for subsense in sense.subsenses {
                                sections.append(.subsense(.init(definition: subsense.definition)))
                            }
                        }
                    }
                }
                self.viewModel = .loaded(sections)
            case let .failure(error):
                print(error)
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        switch viewModel {
        case .loading:
            return 0
        case .loaded:
            return 1
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch viewModel {
        case .loading:
            return 0
        case let .loaded(rows):
            return rows.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard case let .loaded(sections) = viewModel else {
            // TODO: Empty Screen
            fatalError()
        }

        let section = sections[indexPath.row]

        // TODO: Simplify with type erasure
        switch section {
        case let .homographHeader(viewModel):
            let cell: HomographHeaderTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.configure(viewModel: viewModel)
            return cell
        case let .lexicalEntryHeader(viewModel):
            let cell: LexicalEntryHeaderTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.configure(viewModel: viewModel)
            return cell
        case let .sense(viewModel):
            let cell: SenseTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.configure(viewModel: viewModel)
            return cell
        case let .subsense(viewModel):
            let cell: SubsenseTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.configure(viewModel: viewModel)
            return cell
        }
    }
}
