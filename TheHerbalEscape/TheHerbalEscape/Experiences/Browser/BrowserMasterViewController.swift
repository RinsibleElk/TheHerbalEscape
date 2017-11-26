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
            if (isViewLoaded && selectedBrowsable != nil) {
                pushSelectedBrowsableToClients()
            }
        }
    }
    var allBrowsables = [Browsable]()
    var nav : UINavigationController!
    
    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Starter data - TODO find a better way to do this.
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        if (appDelegate != nil) {
            allBrowsables = appDelegate!.contentRepository.Browsables
        }
        
        // On iPhone, start with the table, on iPad, show both.
        self.delegate = self
        self.preferredDisplayMode = .allVisible

        // Register as the client of the table view.
        let nav = viewControllers[0] as? UINavigationController
        if (nav != nil) {
            for child in nav!.childViewControllers {
                let tableVc = child as? BrowserTableViewController
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
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (selectedBrowsable != nil) {
            pushSelectedBrowsableToClients()
        }
    }
    
    // MARK: - BrowsableClient
    func select(browsable: Browsable) {
        selectedBrowsable = browsable
    }
    
    // MARK: - LinkHandler
    func handleLink(linkText: String, content: BrowserContentViewController?) {
        print("Processing link \(linkText)")
        var foundBrowsable : Browsable?
        // TODO: Yikes, must be a dictionary or something
        for browsable in allBrowsables  {
            if browsable.BrowserTitle == linkText {
                foundBrowsable = browsable
                break
            }
        }
        // Going to try something crafty.
        if (foundBrowsable != nil && content != nil) {
            //let content = UIStoryboard(name: Experiences.Browser, bundle: nil).instantiateViewController(withIdentifier: StoryboardIdentifiers.BrowserContentIdentifier) as! BrowserContentViewController
            //content.setLinkHandler(linkHandler: self)
            //content.select(browsable: foundBrowsable!)
            
            //nav.pushViewController(content, animated: true)

            //content!.navigateToBrowsable(browsable: foundBrowsable!)
            
            //selectedBrowsable = foundBrowsable!
            //viewControllers.first?.navigationController?.pushViewController(content, animated: true)
            
            content!.select(browsable: foundBrowsable!)
            
            //self.navigationController?.pushViewController(content, animated: true)
        }
    }
    
    // MARK: - Private functions
    func pushSelectedBrowsableToClients() {
        //nav = UIStoryboard(name: Experiences.Browser, bundle: nil).instantiateViewController(withIdentifier: StoryboardIdentifiers.BrowserContentNavigationIdentifier) as! UINavigationController
        //let contentFirst = nav.viewControllers.first
        //let content = contentFirst! as! BrowserContentViewController
        let content = UIStoryboard(name: Experiences.Browser, bundle: nil).instantiateViewController(withIdentifier: StoryboardIdentifiers.BrowserContentIdentifier) as! BrowserContentViewController
        content.setLinkHandler(linkHandler: self)
        content.select(browsable: selectedBrowsable!)
        showDetailViewController(content, sender: nil)
    }
}
