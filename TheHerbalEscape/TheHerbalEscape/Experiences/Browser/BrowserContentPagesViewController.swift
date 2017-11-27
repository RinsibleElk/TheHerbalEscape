//
//  BrowserContentPagesViewController.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 26/11/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import UIKit

class BrowserContentPagesViewController: UIPageViewController, UIPageViewControllerDataSource, BrowsableClient, LinkHandlerClient, LinkHandler {
    // MARK: - Properties
    var pages = [BrowserPage]()
    private weak var linkHandler : LinkHandler?
    private var orderedViewControllers: [UIViewController] = []

    // MARK: - UIPageViewControllerDataSource
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
    
    // MARK: - BrowsableClient
    func select(browsable: Browsable) {
        title = browsable.BrowserTitle
        pages = browsable.BrowserPages
        if (isViewLoaded) {
            setOrderedViewControllers()
        }
    }

    // MARK: - LinkHandlerClient
    func setLinkHandler(linkHandler: LinkHandler) {
        self.linkHandler = linkHandler
    }
    
    // MARK: - LinkHandler
    func handleLink(linkText: String, content: BrowsableClient?) {
        linkHandler?.handleLink(linkText: linkText, content: self)
    }

    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        dataSource = self
        setOrderedViewControllers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Private functions
    private func setOrderedViewControllers() {
        orderedViewControllers = pages.map({ (page:BrowserPage) -> UIViewController in
            return newContentPageViewController(page: page)
        })
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
    }
    private func newContentPageViewController(page: BrowserPage) -> UIViewController {
        let contentPageVc = UIStoryboard(name: Experiences.Browser, bundle: nil).instantiateViewController(withIdentifier: StoryboardIdentifiers.BrowserContentPageTableIdentifier) as! BrowserContentPageTableViewController
        contentPageVc.setLinkHandler(linkHandler: self)
        contentPageVc.setBrowserPage(browserPage: page)
        return contentPageVc
    }
}
