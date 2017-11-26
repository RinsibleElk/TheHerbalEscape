//
//  BrowserTableViewController.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 25/11/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import UIKit

/// Filterable table view controller for browsing.
class BrowserTableViewController: UITableViewController, UISearchResultsUpdating {
    // MARK: - Properties
    var allResults = [Browsable]()
    var currentResults = [Browsable]()
    var searchController : UISearchController?
    private var browsableClient : BrowsableClient?
    
    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Starter data - TODO find a better way to do this.
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        if (appDelegate != nil) {
            allResults = appDelegate!.contentRepository.Browsables
            currentResults = allResults
        }
        
        // Don't go into content view until I say so.
        clearsSelectionOnViewWillAppear = true
        
        // Set up the search bar.
        searchController = UISearchController(searchResultsController: nil)
        searchController!.searchResultsUpdater = self
        searchController!.obscuresBackgroundDuringPresentation = false
        searchController!.dimsBackgroundDuringPresentation = false
        searchController!.searchBar.placeholder = "Filter..."
        searchController!.searchBar.returnKeyType = .done
        //tableView.tableHeaderView = searchController!.searchBar
        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
            navigationItem.hidesSearchBarWhenScrolling = false
        } else {
            tableView.tableHeaderView = searchController!.searchBar
        }
        definesPresentationContext = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return currentResults.count
        }
        return allResults.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifiers.BrowserTableCellIdentifier, for: indexPath) as! BrowserTableViewCell
        var browsable : Browsable?
        if isFiltering() {
            browsable = currentResults[indexPath.row]
        } else {
            browsable = allResults[indexPath.row]
        }
        cell.browsable = browsable
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pushBrowsableToDetailsView()
    }
    
    // MARK: - UISearchResultsUpdating
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text)
    }
    
    // MARK: - API to Master
    func registerClient(client: BrowsableClient) {
        self.browsableClient = client
    }
    
    // MARK: - Private functions
    private func filterContentForSearchText(searchText: String?) {
        if (searchText == nil) {
            currentResults = allResults
        }
        else {
            // Filter the array using the filter method
            let lcSearchText = searchText!.lowercased()
            self.currentResults = self.allResults.filter({ (browsable:Browsable) -> Bool in
                // to start, let's just search by name
                return browsable.BrowserTitle.lowercased().range(of: lcSearchText) != nil
            })
        }
        tableView.reloadData()
    }
    private func searchBarIsEmpty() -> Bool {
        return searchController?.searchBar.text == nil || searchController?.searchBar.text?.count == 0
    }
    private func isFiltering() -> Bool {
        return searchController!.isActive && !searchBarIsEmpty()
    }
    private func pushBrowsableToDetailsView() {
        var browsable : Browsable?
        let indexPath = tableView.indexPathForSelectedRow
        if (indexPath == nil) {
            browsable = EmptyBrowsable()
        }
        else {
            if isFiltering() {
                browsable = currentResults[indexPath!.row]
            } else {
                browsable = allResults[indexPath!.row]
            }
        }
        browsableClient?.select(browsable: browsable!)
    }
}
