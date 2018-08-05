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

    private var foundWords: [FoundWord] = [] {
        didSet {
            let words = foundWords.map { $0.word }
            let viewModel = SearchResultsTableViewController.ViewModel(words: words)
            self.searchResultsTableViewController.configure(viewModel: viewModel)
        }
    }

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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let selectedIndex = searchResultsTableViewController.tableView.indexPathForSelectedRow?.row else {
            fatalError()
        }

        switch segue.destination {
        case let vc as DefineViewController:
            let wordID = foundWords[selectedIndex].id
            vc.wordID = wordID
            print(wordID)
        default:
            fatalError()
        }
    }
}

// MARK: - UITableViewDelegate

extension SearchTableViewController {

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "segue", sender: nil)
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

        let updateSelector = #selector(update(for:))
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: updateSelector, object: searchController.searchBar)
        perform(updateSelector, with: searchController.searchBar, afterDelay: 1)
    }

    @objc func update(for searchbar: UISearchBar) {

        guard let query = searchController.searchBar.text, !query.isEmpty else {
            return
        }

        let search = Search(query: query)
        let apiClient = OxfordDictionaryClient(environment: Environment())
        apiClient.request(endpoint: search) { result in
            switch result {
            case let .success(wordList):
                self.foundWords = wordList.results ?? []
            case let .failure(error):
                print(error)
            }
        }
    }
}
