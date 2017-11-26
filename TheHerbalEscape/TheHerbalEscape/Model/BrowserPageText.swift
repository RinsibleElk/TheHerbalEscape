//
//  BrowserPageText.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 25/11/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import Foundation

/// A Browser page element representing text with links and formatting.
public class BrowserPageText: Codable {
    /// The text.
    var Text : String
    
    /// The links.
    var Links : [BrowserPageTextLink]
    
    init(text: String, links: [BrowserPageTextLink]) {
        Text = text
        Links = links
    }
}
