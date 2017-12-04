//
//  CollapseHandler.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 03/12/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import Foundation

protocol CollapsibleTableViewHeaderDelegate: class {
    func toggleSection(header: BrowserCollapsibleHeaderView, section: Int)
}
