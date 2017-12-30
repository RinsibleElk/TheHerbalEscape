//
//  BrowserViewController.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 24/12/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import UIKit
import PureLayout

enum BrowserViewMode {
    case regularBoth
    case regularContent
    case compactContent
    case compactTable
    case notsetyet
}

class BrowserViewController: UIViewController, BrowsableClient, LinkHandler {
    // MARK: - Outlets
    @IBOutlet weak var toggleTableViewButton: UIBarButtonItem!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var forwardButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var toolbarView: UIToolbar!
    
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
    private var compactContentConstraints: NSArray?
    private var compactTableConstraints: NSArray?
    private var regularContentConstraints: NSArray?
    private var regularBothConstraints: NSArray?
    private var didSetupConstraints = false
    private var tableVc: BrowserTableViewController?
    private var contentVc: BrowserContentPageTableViewController?
    private var isAnimating = false
    private var tableIsHidden = false
    private var contentIsHidden = false
    private var viewMode: BrowserViewMode = .notsetyet {
        didSet {
            switch viewMode {
            case .compactTable:
                toggleTableViewButton.title = "Hide"
            case .regularBoth:
                toggleTableViewButton.title = "Hide"
            default:
                toggleTableViewButton.title = "Show"
            }
        }
    }
    
    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set button texts.
        toggleTableViewButton.title = "Show"
        backButton.title = "\u{27F5}"
        forwardButton.title = "\u{27F6}"

        // Starter data - TODO find a better way to do this.
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        if (appDelegate != nil) {
            allBrowsables = appDelegate!.contentRepository.Browsables
        }
        
        // Bootstrap auto layout.
        self.updateViewConstraints()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func updateViewConstraints() {
        if (!didSetupConstraints) {
            compactContentConstraints =
                NSLayoutConstraint.autoCreateConstraintsWithoutInstalling {
                    contentView.autoPinEdge(toSuperviewEdge: .top)
                    contentView.autoPinEdge(.bottom, to: .top, of: toolbarView)
                    contentView.autoPinEdge(toSuperviewEdge: .left)
                    contentView.autoPinEdge(toSuperviewEdge: .right)
                    tableView.autoConstrainAttribute(.width, to: .width, of: contentView)
                    tableView.autoConstrainAttribute(.height, to: .height, of: contentView)
                    tableView.autoAlignAxis(.horizontal, toSameAxisOf: contentView)
                    tableView.autoPinEdge(.right, to: .left, of: contentView)
            } as NSArray
            regularContentConstraints =
                NSLayoutConstraint.autoCreateConstraintsWithoutInstalling {
                    contentView.autoPinEdge(toSuperviewEdge: .top)
                    contentView.autoPinEdge(.bottom, to: .top, of: toolbarView)
                    contentView.autoPinEdge(toSuperviewEdge: .left)
                    contentView.autoPinEdge(toSuperviewEdge: .right)
                    tableView.autoSetDimension(.width, toSize: 300)
                    tableView.autoConstrainAttribute(.height, to: .height, of: contentView)
                    tableView.autoAlignAxis(.horizontal, toSameAxisOf: contentView)
                    tableView.autoPinEdge(.right, to: .left, of: contentView)
            } as NSArray
            regularBothConstraints =
                NSLayoutConstraint.autoCreateConstraintsWithoutInstalling {
                    contentView.autoPinEdge(toSuperviewEdge: .top)
                    contentView.autoPinEdge(.bottom, to: .top, of: toolbarView)
                    tableView.autoPinEdge(toSuperviewEdge: .left)
                    contentView.autoPinEdge(toSuperviewEdge: .right)
                    tableView.autoSetDimension(.width, toSize: 300)
                    tableView.autoConstrainAttribute(.height, to: .height, of: contentView)
                    tableView.autoAlignAxis(.horizontal, toSameAxisOf: contentView)
                    tableView.autoPinEdge(.right, to: .left, of: contentView)
            } as NSArray
            compactTableConstraints =
                NSLayoutConstraint.autoCreateConstraintsWithoutInstalling {
                    tableView.autoPinEdge(toSuperviewEdge: .top)
                    tableView.autoPinEdge(.bottom, to: .top, of: toolbarView)
                    tableView.autoPinEdge(toSuperviewEdge: .left)
                    tableView.autoPinEdge(toSuperviewEdge: .right)
                    contentView.autoConstrainAttribute(.width, to: .width, of: tableView)
                    contentView.autoConstrainAttribute(.height, to: .height, of: tableView)
                    contentView.autoAlignAxis(.horizontal, toSameAxisOf: tableView)
                    contentView.autoPinEdge(.left, to: .right, of: tableView)
            } as NSArray
            didSetupConstraints = true
        }
        super.updateViewConstraints()
    }
    
    private func noAnimationSwitchConstraints(targetMode: BrowserViewMode) {
        if (targetMode != viewMode) {
            if (viewMode != .notsetyet) {
                switch viewMode {
                case .compactContent:
                    compactContentConstraints!.autoRemoveConstraints()
                case .compactTable:
                    compactTableConstraints!.autoRemoveConstraints()
                case .regularBoth:
                    regularBothConstraints!.autoRemoveConstraints()
                case .regularContent:
                    regularContentConstraints!.autoRemoveConstraints()
                default:
                    NSLog("Error occurred")
                }
            }
            if (targetMode != .notsetyet) {
                switch targetMode {
                case .compactContent:
                    compactContentConstraints!.autoInstallConstraints()
                    tableIsHidden = true
                    contentIsHidden = false
                    tableView.isHidden = true
                    contentView.isHidden = false
                case .compactTable:
                    compactTableConstraints!.autoInstallConstraints()
                    tableIsHidden = false
                    contentIsHidden = true
                    tableView.isHidden = false
                    contentView.isHidden = true
                case .regularBoth:
                    regularBothConstraints!.autoInstallConstraints()
                    tableIsHidden = false
                    contentIsHidden = false
                    tableView.isHidden = false
                    contentView.isHidden = false
                case .regularContent:
                    regularContentConstraints!.autoInstallConstraints()
                    tableIsHidden = true
                    contentIsHidden = false
                    tableView.isHidden = true
                    contentView.isHidden = false
                default:
                    NSLog("Error occurred")
                }
            }
            viewMode = targetMode
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        switch traitCollection.horizontalSizeClass {
        case .compact:
            animateSwitchConstraints(targetMode: .compactTable)
        default:
            animateSwitchConstraints(targetMode: .regularBoth)
        }
        super.traitCollectionDidChange(previousTraitCollection)
    }
    
    private func animateSwitchConstraints(targetMode: BrowserViewMode) {
        if (targetMode != viewMode) {
            var constraintsToRemove: NSArray?
            var constraintsToInstall: NSArray?
            if (viewMode != .notsetyet) {
                switch viewMode {
                case .compactContent:
                    constraintsToRemove = compactContentConstraints!
                case .compactTable:
                    constraintsToRemove = compactTableConstraints!
                case .regularBoth:
                    constraintsToRemove = regularBothConstraints!
                case .regularContent:
                    constraintsToRemove = regularContentConstraints!
                default:
                    NSLog("Error occurred")
                }
            }
            var hideTable = false
            var hideContent = false
            if (targetMode != .notsetyet) {
                switch targetMode {
                case .compactContent:
                    constraintsToInstall = compactContentConstraints!
                    hideTable = true
                    hideContent = false
                case .compactTable:
                    constraintsToInstall = compactTableConstraints!
                    hideTable = false
                    hideContent = true
                case .regularBoth:
                    constraintsToInstall = regularBothConstraints!
                    hideTable = false
                    hideContent = false
                case .regularContent:
                    constraintsToInstall = regularContentConstraints!
                    hideTable = true
                    hideContent = false
                default:
                    NSLog("Error occurred")
                }
            }
            if (constraintsToRemove == nil || constraintsToInstall == nil) {
                noAnimationSwitchConstraints(targetMode: targetMode)
            }
            else if !isAnimating {
                isAnimating = true
                let toRemove = constraintsToRemove!
                let toInstall = constraintsToInstall!
                tableIsHidden = false
                contentIsHidden = false
                tableView.isHidden = false
                contentView.isHidden = false
                UIView.animate(withDuration: 0.5, animations: {
                    toRemove.autoRemoveConstraints()
                    toInstall.autoInstallConstraints()
                    self.view.layoutIfNeeded()
                }, completion: { (finished) in
                    self.isAnimating = false
                    self.viewMode = targetMode
                    self.tableView.isHidden = hideTable
                    self.contentView.isHidden = hideContent
                    self.tableIsHidden = hideTable
                    self.contentIsHidden = hideContent
                })
            }
        }
    }
    
    override func viewWillLayoutSubviews() {
        if (viewMode == .notsetyet) {
            switch self.traitCollection.horizontalSizeClass {
            case .compact:
                noAnimationSwitchConstraints(targetMode: .compactTable)
            default:
                noAnimationSwitchConstraints(targetMode: .regularBoth)
            }
        }
        super.viewWillLayoutSubviews()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let segueIdentifier = segue.identifier {
            switch segueIdentifier {
            case SegueIdentifiers.BrowserTableEmbedSegueIdentifier:
                tableVc = segue.destination as? BrowserTableViewController
                tableVc?.registerClient(client: self)
            case SegueIdentifiers.BrowserContentEmbedSegueIdentifier:
                contentVc = segue.destination as? BrowserContentPageTableViewController
            default:
                NSLog("Unknown segue from browser: ", segueIdentifier)
            }
        }
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
        contentVc?.setLinkHandler(linkHandler: self)
        contentVc?.selectBrowsable(browsable: selectedBrowsable!)
        if traitCollection.horizontalSizeClass == .compact {
            animateSwitchConstraints(targetMode: .compactContent)
        }
    }
    
    // MARK: - Gesture handlers
    @IBAction func swipeRight(_ sender: UISwipeGestureRecognizer) {
        // If we're in compact mode, then do a show hide with the table.
        // If we're in regular mode, then shrink the content to show the table with width 300.
        if (self.traitCollection.horizontalSizeClass == .compact) {
            animateSwitchConstraints(targetMode: .compactTable)
        }
        else {
            animateSwitchConstraints(targetMode: .regularBoth)
        }
    }
    @IBAction func swipeLeft(_ sender: UISwipeGestureRecognizer) {
        if (self.traitCollection.horizontalSizeClass == .compact) {
            animateSwitchConstraints(targetMode: .compactContent)
        }
        else {
            animateSwitchConstraints(targetMode: .regularContent)
        }
    }
    @IBAction func toggleTableView(_ sender: UIBarButtonItem) {
        if (self.traitCollection.horizontalSizeClass == .compact) {
            if (viewMode == .compactContent) {
                animateSwitchConstraints(targetMode: .compactTable)
            }
            else {
                animateSwitchConstraints(targetMode: .compactContent)
            }
        }
        else if (viewMode == .regularContent) {
            animateSwitchConstraints(targetMode: .regularBoth)
        }
        else {
            animateSwitchConstraints(targetMode: .regularContent)
        }
    }
}
