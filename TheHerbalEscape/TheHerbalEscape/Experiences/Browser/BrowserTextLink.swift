//
//  BrowserTextLink.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 02/12/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import Foundation

class BrowserTextLink {
    // MARK: - Properties
    var range: NSRange
    var target: String
    
    // MARK: - Initializers
    init(range: NSRange, target: String) {
        self.range = range
        self.target = target
    }
    
    // MARK: - API
    func adjustLocation(offset: Int) {
        let newLocation = range.location + offset
        range = NSRange(location: newLocation, length: range.length)
    }
}
