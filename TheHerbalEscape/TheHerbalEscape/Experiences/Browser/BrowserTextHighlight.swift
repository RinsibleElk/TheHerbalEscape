//
//  BrowserTextHighlight.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 02/12/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import Foundation

/// All the ranges and their highlights.
class BrowserTextHighlight {
    // MARK: - Properties
    var range: NSRange
    var highlightTypes: [BrowserTextHighlightType]
    
    // MARK: - Initializers
    init(range: NSRange, highlightTypes: [BrowserTextHighlightType]) {
        self.range = range
        self.highlightTypes = highlightTypes
    }
    
    // MARK: - API
    func split(range: NSRange, highlightType: BrowserTextHighlightType) -> [BrowserTextHighlight] {
        var retVal = [BrowserTextHighlight]()
        if (range.location > self.range.location) {
            retVal.append(BrowserTextHighlight(range: NSRange(location: self.range.location, length: range.location - self.range.location), highlightTypes: self.highlightTypes))
        }
        var appendedTypes = highlightTypes
        appendedTypes.append(highlightType)
        retVal.append(BrowserTextHighlight(range: range, highlightTypes: appendedTypes))
        if (range.location + range.length < self.range.location + self.range.length) {
            retVal.append(BrowserTextHighlight(range: NSRange(location: range.location + range.length, length: self.range.location + self.range.length - range.location - range.length), highlightTypes: self.highlightTypes))
        }
        return retVal
    }
    
    func adjustLocation(offset: Int) {
        let newLocation = range.location + offset
        let newLength = range.length
        range = NSRange(location: newLocation, length: newLength)
    }
    
    func adjustLength(offset: Int) {
        let newLocation = range.location
        let newLength = range.length + offset
        range = NSRange(location: newLocation, length: newLength)
    }
}
