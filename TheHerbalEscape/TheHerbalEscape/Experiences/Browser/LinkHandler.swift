//
//  LinkHandler.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 26/11/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import Foundation

/// Declared by components that can handle links to external browsers or within this one.
protocol LinkHandler : class {
    func handleLink(linkText: String, content: BrowsableClient?)
}
