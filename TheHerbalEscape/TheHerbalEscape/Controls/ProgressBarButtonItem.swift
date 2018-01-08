//
//  ProgressBarButtonItem.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 08/01/2018.
//  Copyright © 2018 Oliver Samson. All rights reserved.
//

import UIKit

@IBDesignable class ProgressBarButtonItem: UIBarButtonItem {
    // MARK: - Inspectable properties
    @IBInspectable var numberOfSections: Int = 4 {
        didSet {
            progressControl?.numberOfSections = numberOfSections
        }
    }
    
    @IBInspectable var numberAchieved: Int = 2 {
        didSet {
            progressControl?.numberAchieved = numberAchieved
        }
    }
    
    @IBInspectable var achievedColor: UIColor = UIColor.blue {
        didSet {
            progressControl?.achievedColor = achievedColor
        }
    }
    
    @IBInspectable var unachievedColor: UIColor = UIColor.lightGray {
        didSet {
            progressControl?.unachievedColor = unachievedColor
        }
    }
    
    @IBInspectable var spacing: CGFloat = 5.0 {
        didSet {
            progressControl?.spacing = spacing
        }
    }

    // MARK: - Private properties
    private var progressControl: ProgressControl?

    // MARK: - UIBarButtonItem
    override func awakeFromNib() {
        super.awakeFromNib()
        progressControl = ProgressControl()
        progressControl!.numberOfSections = numberOfSections
        progressControl!.numberAchieved = numberAchieved
        progressControl!.achievedColor = achievedColor
        progressControl!.unachievedColor = unachievedColor
        progressControl!.spacing = spacing
        customView = progressControl!
    }
}
