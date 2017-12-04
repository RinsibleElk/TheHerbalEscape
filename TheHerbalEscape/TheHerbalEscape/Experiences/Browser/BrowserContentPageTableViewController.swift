//
//  BrowserContentPageTableViewController.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 26/11/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import UIKit

class BrowserContentPageTableViewController: UITableViewController, BrowsableClient, LinkHandlerClient, CollapseHandler {
    // MARK: - Private properties
    private weak var linkHandler: LinkHandler!
    private var sections = [BrowserContentSection]()
    private var browsableTitle = "No browsable loaded"
    private var isCollapsed = [Bool]()
    
    // MARK: - LinkHandlerClient
    func setLinkHandler(linkHandler: LinkHandler) {
        self.linkHandler = linkHandler
    }
    
    // MARK: - BrowsableClient
    func selectBrowsable(browsable: Browsable) {
        self.browsableTitle = browsable.BrowsableTitle
        self.sections = browsable.BrowsableSections
        self.isCollapsed = sections.map({ (section:BrowserContentSection) -> Bool in
            if !section.IsCollapsible {
                return false
            }
            else {
                return true
            }
        })
        tableView.reloadData()
    }
    
    // MARK: - CollapseHandler
    func toggleCollapsed(_ index: Int) {
        self.isCollapsed[index] = !self.isCollapsed[index]
        let indexSet = IndexSet(integer: index)
        tableView.reloadSections(indexSet, with: .top)
    }

    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()

        // Header nibs.
        let titleNib = UINib(nibName: StoryboardIdentifiers.BrowserTitleHeaderView, bundle: nil)
        tableView.register(titleNib, forHeaderFooterViewReuseIdentifier: ReuseIdentifiers.BrowserContentPageTitleSectionHeaderIdentifier)
        let collapsibleNib = UINib(nibName: StoryboardIdentifiers.BrowserCollapsibleHeaderView, bundle: nil)
        tableView.register(collapsibleNib, forHeaderFooterViewReuseIdentifier: ReuseIdentifiers.BrowserContentPageCollapsibleSectionHeaderIdentifier)

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
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isCollapsed[section] {
            return 0
        }
        else {
            return sections[section].Elements.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.section]
        let element = section.Elements[indexPath.row]
        var cell : UITableViewCell!
        switch element {
        case .image(let image):
            let imageCell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifiers.BrowserContentPageImageTableCellIdentifier, for: indexPath) as! BrowserContentPageImageTableViewCell
            imageCell.imageElement = image
            cell = imageCell
        case .text(let paragraph):
            let textCell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifiers.BrowserContentPageTextTableCellIdentifier, for: indexPath) as! BrowserContentPageTextTableViewCell
            textCell.paragraph = paragraph
            textCell.setLinkHandler(linkHandler: linkHandler!)
            cell = textCell
            cell.tag = indexPath.row
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection sectionIndex: Int) -> CGFloat {
        let section = sections[sectionIndex]
        if section.IsCollapsible {
            return 30
        }
        else {
            return 60
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection sectionIndex: Int) -> UIView? {
        let section = sections[sectionIndex]
        if section.IsCollapsible {
            let sectionView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ReuseIdentifiers.BrowserContentPageCollapsibleSectionHeaderIdentifier) as! BrowserCollapsibleHeaderView
            sectionView.titleLabelView.text = section.Title
            sectionView.Index = sectionIndex
            sectionView.CollapseHandler = self
            return sectionView
        }
        else {
            let sectionView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ReuseIdentifiers.BrowserContentPageTitleSectionHeaderIdentifier) as! BrowserTitleHeaderView
            sectionView.titleLabelView.text = section.Title
            return sectionView
        }
    }
}
