//
//  BrowseItemViewController.swift
//  Playpen
//
//  Created by Oliver Samson on 23/11/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import UIKit

class BrowseItemViewController: UIPageViewController, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard pages.count > previousIndex else {
            return nil
        }
        
        return pages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = pages.count
        
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return pages[nextIndex]
    }

    var learnables: [Learnable] = [Learnable]()
    var learnableIndex: Int = 0
    var pages = [UIViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        let learnable = learnables[learnableIndex]
        title = learnable.title
        pages =
            [
                BrowseItemPageViewController(learnable: learnable, pageIndex: 0),
                BrowseItemPageViewController(learnable: learnable, pageIndex: 1),
                BrowseItemPageViewController(learnable: learnable, pageIndex: 2),
                BrowseItemPageViewController(learnable: learnable, pageIndex: 3)
            ]
        dataSource = self
        setViewControllers([pages.first!], direction: .forward, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
