//
//  SearchViewController.swift
//  Foreignforce
//
//  Created by Yusei Nishiyama on 27/05/2018.
//  Copyright © 2018 Yusei Nishiyama. All rights reserved.
//

import Foundation
import UIKit
import OxfordDictionary

class SearchTableViewController: UITableViewController {

    lazy var searchController: UISearchController = {
        return UISearchController(searchResultsController: searchResultsTableViewController)
    }()

    lazy var searchResultsTableViewController = SearchResultsTableViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        searchResultsTableViewController.tableView.delegate = self

        searchController.searchResultsUpdater = self
        searchController.searchBar.sizeToFit()

        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationItem.searchController = searchController
            navigationItem.hidesSearchBarWhenScrolling = false
        } else {
            tableView.tableHeaderView = searchController.searchBar
        }

        searchController.delegate = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self

        /*
         Search is now just presenting a view controller. As such, normal view controller
         presentation semantics apply. Namely that presentation will walk up the view controller
         hierarchy until it finds the root view controller or one that defines a presentation context.
         */
        definesPresentationContext = true
    }
}

// MARK: - UITableViewDataSource

extension SearchTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "identifier", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row)"

        return cell
    }

}

// MARK: - UITableViewDelegate

extension SearchTableViewController {

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }
}

// MARK: - UISearchBarDelegate

extension SearchTableViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

}

// MARK: - UISearchControllerDelegate

extension SearchTableViewController: UISearchControllerDelegate {

    func presentSearchController(_ searchController: UISearchController) {
        //debugPrint("UISearchControllerDelegate invoked method: \(__FUNCTION__).")
    }

    func willPresentSearchController(_ searchController: UISearchController) {
        //debugPrint("UISearchControllerDelegate invoked method: \(__FUNCTION__).")
    }

    func didPresentSearchController(_ searchController: UISearchController) {
        //debugPrint("UISearchControllerDelegate invoked method: \(__FUNCTION__).")
    }

    func willDismissSearchController(_ searchController: UISearchController) {
        //debugPrint("UISearchControllerDelegate invoked method: \(__FUNCTION__).")
    }

    func didDismissSearchController(_ searchController: UISearchController) {
        //debugPrint("UISearchControllerDelegate invoked method: \(__FUNCTION__).")
    }

}

// MARK: - UISearchResultsUpdating

extension SearchTableViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {

        guard let query = searchController.searchBar.text, !query.isEmpty else {
            return
        }

        let entries = Entries(wordID: query)
        let apiClient = OxfordDictionaryAPIClient()
        apiClient.request(endpoint: entries) { result in
            switch result {
            case let .success(retrieveEntry):
                let words = retrieveEntry.results?.map { $0.word } ?? []
                self.searchResultsTableViewController.words = words

                DispatchQueue.main.async {
                    self.searchResultsTableViewController.tableView.reloadData()
                }
            case let .failure(error):
                print(error)
            }
        }
    }
}
