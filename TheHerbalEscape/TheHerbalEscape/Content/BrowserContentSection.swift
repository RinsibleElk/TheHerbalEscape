//
//  BrowserContentSection.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 01/12/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import Foundation

/// A section of browser content.
class BrowserContentSection {
    // MARK: - Properties
    var Title: String
    var IsCollapsible: Bool
    var Elements: [BrowserContentElement]
    
    // MARK: - Initializers
    init(title: String, isCollapsible: Bool, elements: [BrowserContentElement]) {
        Title = title
        IsCollapsible = isCollapsible
        Elements = elements
    }
}
