//
//  BrowserPageHeader.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 25/11/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import Foundation

/// A Browser page element representing a heading.
public class BrowserPageHeading: Codable {
    /// The heading text.
    var Text : String
    
    /// The heading level (1-6).
    var Level : Int
    
    init(text: String, level: Int) {
        Text = text
        Level = level
    }
}
