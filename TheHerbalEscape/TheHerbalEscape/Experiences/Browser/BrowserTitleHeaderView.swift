//
//  BrowserTitleHeaderView.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 03/12/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import UIKit

class BrowserTitleHeaderView: UITableViewHeaderFooterView {
    @IBOutlet weak var wrapperView: UIView!
    @IBOutlet weak var titleLabelView: UILabel!
    override var contentView: UIView {
        get {
            return wrapperView
        }
    }
}
