//
//  BrowseTableViewController.swift
//  Playpen
//
//  Created by Oliver Samson on 23/11/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import UIKit

class BrowseTableViewController: UITableViewController, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text)
    }
    
    var searchController : UISearchController?
    var backgroundView : UIImageView!
    var allResults = [Learnable]()
    var currentResults = [Learnable]()
    func filterContentForSearchText(searchText: String?) {
        if (searchText == nil) {
            currentResults = allResults
        }
        else {
            // Filter the array using the filter method
            let lcSearchText = searchText!.lowercased()
            self.currentResults = self.allResults.filter({( learnable: Learnable) -> Bool in
                // to start, let's just search by name
                return learnable.title.lowercased().range(of: lcSearchText) != nil
            })
        }
        tableView.reloadData()
    }
    func searchBarIsEmpty() -> Bool {
        return searchController?.searchBar.text == nil || searchController?.searchBar.text?.count == 0
    }
    func isFiltering() -> Bool {
        return searchController!.isActive && !searchBarIsEmpty()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        allResults =
            [
                Learnable(category: "Flower", title: "Balisse", translation: "Essilab", image: #imageLiteral(resourceName: "balisse")),
                Learnable(category: "Flower", title: "Berbercane", translation: "Enacrebreb", image: #imageLiteral(resourceName: "berbercane")),
                Learnable(category: "Flower", title: "Crow's Eye", translation: "Eye Sworc", image: #imageLiteral(resourceName: "crows_eye")),
                Learnable(category: "Flower", title: "Feainnewedd", translation: "Ddewenniaef", image: #imageLiteral(resourceName: "feainnewedd")),
                Learnable(category: "Flower", title: "Fool's Parsley", translation: "Yelsrap Sloof", image: #imageLiteral(resourceName: "fools parsley")),
                Learnable(category: "Flower", title: "Beggartick", translation: "Kcitraggeb", image: #imageLiteral(resourceName: "beggartick_blossom")),
                Learnable(category: "Flower", title: "Ginatia", translation: "Aitanig", image: #imageLiteral(resourceName: "ginatia")),
                Learnable(category: "Flower", title: "White Myrtle", translation: "Eltrym Etihw", image: #imageLiteral(resourceName: "white_myrtle"))
            ]
        currentResults = allResults

        searchController = UISearchController(searchResultsController: nil)
        searchController!.searchResultsUpdater = self
        searchController!.obscuresBackgroundDuringPresentation = false
        searchController!.dimsBackgroundDuringPresentation = false
        searchController!.searchBar.placeholder = "Filter..."
        tableView.tableHeaderView = searchController!.searchBar
        definesPresentationContext = true
        
        definesPresentationContext = true

        backgroundView = UIImageView(image: #imageLiteral(resourceName: "portraitbg"))
        backgroundView.alpha = 0.3
        self.tableView.backgroundView = backgroundView

        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return currentResults.count
        }
        
        return allResults.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: ReuseIdentifiers.BrowseTableReuseIdentifier, for: indexPath) as! BrowseTableViewCell
        // Configure the cell...
        cell.backgroundColor = UIColor.clear
        var newLearnable : Learnable?
        if isFiltering() {
            newLearnable = currentResults[indexPath.row]
        } else {
            newLearnable = allResults[indexPath.row]
        }
        cell.setLearnable(newLearnable: newLearnable!)

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
