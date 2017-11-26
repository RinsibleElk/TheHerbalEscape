//
//  BrowserContentPageTableViewController.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 26/11/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import UIKit

class BrowserContentPageTableViewController: UITableViewController, BrowserPageClient, LinkHandlerClient {
    // MARK: - Private properties
    private var linkHandler: LinkHandler!
    private var elements = [BrowserPageElement]()
    
    // MARK: - LinkHandlerClient
    func setLinkHandler(linkHandler: LinkHandler) {
        self.linkHandler = linkHandler
    }
    
    // MARK: - BrowserPageClient
    func setBrowserPage(browserPage: BrowserPage) {
        self.elements = browserPage.Elements
        tableView.reloadData()
    }
    
    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()

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
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let element = elements[indexPath.row]
        var cell : UITableViewCell!
        switch element {
        case .heading(let heading):
            let headingCell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifiers.BrowserContentPageHeadingTableCellIdentifier, for: indexPath) as! BrowserContentPageHeadingTableViewCell
            headingCell.heading = heading
            cell = headingCell
        case .image(let image):
            let imageCell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifiers.BrowserContentPageImageTableCellIdentifier, for: indexPath) as! BrowserContentPageImageTableViewCell
            imageCell.imageElement = image
            cell = imageCell
        case .etymology(let etymology):
            if etymology.Phrase2 == nil {
                let etymologyCell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifiers.BrowserContentPageEtymologyTableCellIdentifier, for: indexPath) as! BrowserContentPageEtymologyTableViewCell
                etymologyCell.etymology = etymology
                cell = etymologyCell
            }
            else {
                let etymologyCell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifiers.BrowserContentPageEtymology2TableCellIdentifier, for: indexPath) as! BrowserContentPageEtymology2TableViewCell
                etymologyCell.etymology = etymology
                cell = etymologyCell
            }
        case .text(let text):
            let textCell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifiers.BrowserContentPageTextTableCellIdentifier, for: indexPath) as! BrowserContentPageTextTableViewCell
            textCell.textElement = text
            textCell.setLinkHandler(linkHandler: linkHandler!)
            cell = textCell
            cell.tag = indexPath.row
        }
        return cell
    }
}
