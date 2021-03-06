//
//  BrowserMasterViewController.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 25/11/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import UIKit

class BrowserMasterViewController: UISplitViewController, UISplitViewControllerDelegate, BrowsableClient, LinkHandler {
    // MARK: - Properties
    var selectedBrowsable : Browsable? {
        didSet {
            // Dismiss the keyboard if filtering.
            // TODO There might be a cleaner way to do this - https://stackoverflow.com/questions/29925373/how-to-make-keyboard-dismiss-when-i-press-out-of-searchbar-on-swift
            // I think this solution leads to transaction synchronize issue, plus doesn't quite reform the views correctly.
            // Use delegate?
            tableVc?.searchController?.searchBar.resignFirstResponder()
            
            // Push the browsable to the content pane / page.
            if (isViewLoaded && selectedBrowsable != nil) {
                pushSelectedBrowsableToClients()
            }
        }
    }
    var allBrowsables = [Browsable]()
    private var tableVc : BrowserTableViewController?
    
    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Starter data - TODO find a better way to do this.
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        if (appDelegate != nil) {
            allBrowsables = appDelegate!.contentRepository.Browsables
        }
        
        // On compact width, start with the table (by ensuring we start with no selection), on regular width, show both table and content together.
        self.delegate = self
        self.preferredDisplayMode = .allVisible

        // Register as the client of the table view.
        let nav = viewControllers[0] as? UINavigationController
        if (nav != nil) {
            for child in nav!.childViewControllers {
                tableVc = child as? BrowserTableViewController
                tableVc?.registerClient(client: self)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UISplitViewControllerDelegate
    override func collapseSecondaryViewController(_ secondaryViewController: UIViewController, for splitViewController: UISplitViewController) {
        
    }
    
    // MARK: - BrowsableClient
    func selectBrowsable(browsable: Browsable) {
        selectedBrowsable = browsable
    }
    
    // MARK: - LinkHandler
    func handleLink(linkText: String, content: BrowsableClient?) {
        /// If it is obviously a web link, then handle it.
        if linkText.starts(with: "http") {
            if let url = URL(string: linkText) {
                UIApplication.shared.open(url, options: [:], completionHandler: { (_) in
                })
            }
        }
        else {
            var foundBrowsable : Browsable?
            // TODO: Yikes, must be a dictionary by name or something.
            for browsable in allBrowsables  {
                if browsable.BrowsableTitle == linkText {
                    foundBrowsable = browsable
                    break
                }
            }
            // Clearly when we are handling a link, we already have content visible.
            // Just push the page down. It will show up as a page transition in the content.
            if (foundBrowsable != nil && content != nil) {
                content!.selectBrowsable(browsable: foundBrowsable!)
            }
        }
    }
    
    // MARK: - Private functions
    func pushSelectedBrowsableToClients() {
        let content = UIStoryboard(name: Experiences.Browser, bundle: nil).instantiateViewController(withIdentifier: StoryboardIdentifiers.BrowserContentPageTableIdentifier) as! BrowserContentPageTableViewController
        content.setLinkHandler(linkHandler: self)
        content.selectBrowsable(browsable: selectedBrowsable!)
        showDetailViewController(content, sender: nil)
    }
}
