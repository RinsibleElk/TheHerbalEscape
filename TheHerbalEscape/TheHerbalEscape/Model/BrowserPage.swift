//
//  BrowserPage.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 25/11/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import Foundation

/// A page in the browser.
public class BrowserPage: Codable {
    /// Elements.
    var Elements : [BrowserPageElement]
    init(elements:[BrowserPageElement]) {
        Elements = elements
    }
}
