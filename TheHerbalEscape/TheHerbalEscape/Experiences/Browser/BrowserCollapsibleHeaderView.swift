//
//  BrowserCollapsibleHeaderView.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 03/12/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import UIKit

class BrowserCollapsibleHeaderView: UITableViewHeaderFooterView {
    // MARK: - Outlets
    @IBOutlet weak var wrapperView: UIView!
    @IBOutlet weak var titleLabelView: UILabel!
    @IBAction func toggleCollapsed(_ sender: UIButton) {
        CollapseHandler.toggleCollapsed(Index)
    }
    
    // MARK: - Properties
    var Index : Int = 0
    weak var CollapseHandler : CollapseHandler!
    
    // MARK: - Overrides
    override var contentView: UIView {
        get {
            return wrapperView
        }
    }
}
