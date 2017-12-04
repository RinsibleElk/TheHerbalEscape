//
//  BrowserTextStorage.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 02/12/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import Foundation

/// Dynamically created layout for browser text.
class BrowserTextLayout {
    // MARK: - Private properties
    private var _paragraphs = [BrowserTextParagraph]()
    
    // MARK: - Properties
    var paragraphs : [BrowserTextParagraph] {
        get {
            return _paragraphs
        }
    }
    
    // MARK: - Initializers
    init(_ markdownRawText: String) {
        
        // Normalise line endings.
        let crlfFixed = markdownRawText.replacingOccurrences(of: "\\r\\n", with: "\\n")
        let crFixed = crlfFixed.replacingOccurrences(of: "\\r", with: "\\n")

        // Find paragraphs.
        var currentLocation = 0
        enumerateMatches(regex: Regexes.ParagraphsRegex, string: crFixed) { checkingResult in
            let substring = crFixed[currentLocation ... (checkingResult.range.location - 1)]
            _paragraphs.append(BrowserTextParagraph(substring))
            currentLocation = checkingResult.range.location + checkingResult.range.length
        }
        if (currentLocation < crFixed.count) {
            let substring = crFixed[currentLocation ... (crFixed.count - 1)]
            _paragraphs.append(BrowserTextParagraph(substring))
        }
    }
}
