//
//  BrowserContentPageTableViewController.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 26/11/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import UIKit

class BrowserContentPageTableViewController: UITableViewController, BrowsableClient, LinkHandlerClient, CollapsibleTableViewHeaderDelegate {
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
    
    // MARK: - CollapsibleTableViewHeaderDelegate
    func toggleSection(header: BrowserCollapsibleHeaderView, section: Int) {
        self.isCollapsed[section] = !self.isCollapsed[section]
        let indexSet = IndexSet(integer: section)
        header.setCollapsed(collapsed: self.isCollapsed[section])
        tableView.reloadSections(indexSet, with: .none)
    }

    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()

        // Automatic resizing.
        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedSectionHeaderHeight = 40.0
        tableView.sectionHeaderHeight = UITableViewAutomaticDimension
        tableView.sectionFooterHeight = 1.0
        
        // Separators
        tableView.separatorStyle = .none
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
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
            return UITableViewAutomaticDimension
        }
        else {
            return 60
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection sectionIndex: Int) -> UIView? {
        let section = sections[sectionIndex]
        if section.IsCollapsible {
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: ReuseIdentifiers.BrowserContentPageCollapsibleSectionHeaderIdentifier) as? BrowserCollapsibleHeaderView ?? BrowserCollapsibleHeaderView(reuseIdentifier: ReuseIdentifiers.BrowserContentPageCollapsibleSectionHeaderIdentifier)
            header.titleLabel.text = section.Title
            header.arrowLabel.text = ">"
            header.setCollapsed(collapsed: isCollapsed[sectionIndex])
            header.Index = sectionIndex
            header.delegate = self
            return header
        }
        else {
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: ReuseIdentifiers.BrowserContentPageTitleSectionHeaderIdentifier) as? BrowserTitleHeaderView ?? BrowserTitleHeaderView(reuseIdentifier: ReuseIdentifiers.BrowserContentPageTitleSectionHeaderIdentifier)
            header.titleLabel.text = section.Title
            return header
        }
    }
}
