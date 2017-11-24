//
//  BrowseItemPageViewController.swift
//  Playpen
//
//  Created by Oliver Samson on 23/11/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import UIKit
import PureLayout

class BrowseItemPageViewController: UIViewController {
    var pageIndex : Int = 0
    var learnable : Learnable!
    var viewConstraints : NSArray?
    var didSetupConstraints = false
    var backgroundView : UIImageView!
    var innerView : UIView!

    init(learnable: Learnable, pageIndex: Int) {
        super.init(nibName: nil, bundle: nil)
        self.learnable = learnable
        self.pageIndex = pageIndex
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switch pageIndex {
        case 0:
            let v = UILabel()
            innerView = v
            v.text = learnable.title
            v.textAlignment = .center
        case 1:
            let v = UILabel()
            innerView = v
            v.text = learnable.translation
            v.textAlignment = .center
        case 2:
            let v = UIImageView()
            innerView = v
            v.image = learnable.image
        default:
            let v = UILabel()
            innerView = v
            v.text = learnable.title
            v.textAlignment = .center
        }
        backgroundView = UIImageView(image: #imageLiteral(resourceName: "portraitbg"))
        backgroundView.alpha = 0.3
        backgroundView.contentMode = .scaleToFill
        innerView.backgroundColor = UIColor.clear
        view.addSubview(backgroundView)
        view.addSubview(innerView)
        
        // Bootstrap Auto Layout
        view.setNeedsUpdateConstraints()
    }

    override func updateViewConstraints() {
        super.updateViewConstraints()
        if (!didSetupConstraints) {
            // Note that we use autoCreateAndInstallConstraints() here in order to easily collect all the constraints into a single array.
            viewConstraints = NSLayoutConstraint.autoCreateAndInstallConstraints {
                self.backgroundView.autoPinEdgesToSuperviewEdges()
                self.innerView.autoPinEdgesToSuperviewMargins
                } as NSArray?
            didSetupConstraints = true
        }
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
