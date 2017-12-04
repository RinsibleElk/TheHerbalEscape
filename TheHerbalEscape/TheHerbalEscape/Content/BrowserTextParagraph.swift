//
//  BrowserTextParagraph.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 02/12/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import Foundation

class BrowserTextParagraph {
    // MARK: - Private properties
    private var _text : String!
    private var _links = [BrowserTextLink]()
    private var _highlights = [BrowserTextHighlight]()

    // MARK: - Properties
    var text : String {
        get {
            return _text
        }
    }
    var links : [BrowserTextLink] {
        get {
            return _links
        }
    }

    /// Guaranteed to cover the full length of the string with no overlapping.
    var highlights : [BrowserTextHighlight] {
        get {
            return _highlights
        }
    }

    // MARK: - Initializers
    init(_ paragraphText: String) {
        // Starting.
        var currentText = paragraphText
        var currentNSString = currentText as NSString
        var currentLinks = [BrowserTextLink]()
        var currentHighlights = [BrowserTextHighlight(range: NSRange(location: 0, length: currentNSString.length), highlightTypes: [])]
        
        // Links.
        let linkMatches = Regexes.LinkRegex.matches(in: currentText, options: [], range: NSRange(location: 0, length: currentNSString.length))
        var currentOffset = 0
        for linkMatch in linkMatches {
            let adjustedLinkMatch = linkMatch.adjustingRanges(offset: currentOffset)
            let fullNSRange = adjustedLinkMatch.range(at: 0)
            let targetNSRange = adjustedLinkMatch.range(at: 1)
            currentOffset = currentOffset + targetNSRange.length - fullNSRange.length
            
            // First, replace the text at full range by the text at target range.
            // Add a link with the range and target.
            // Set up the highlight.
            let targetString = currentNSString.substring(with: targetNSRange)
            currentText = currentNSString.replacingCharacters(in: fullNSRange, with: targetString)
            currentNSString = currentText as NSString
            
            // Walk through the highlights, adjusting them for the text replacement and for the highlight.
            var newHighlights = [BrowserTextHighlight]()
            let newTargetRange = NSRange(location: fullNSRange.location, length: targetNSRange.length)
            for highlight in currentHighlights {
                if highlight.range.location + highlight.range.length < fullNSRange.location {
                    newHighlights.append(highlight)
                }
                else if (highlight.range.location > fullNSRange.location + fullNSRange.length) {
                    highlight.adjustLocation(offset: targetNSRange.length - fullNSRange.length)
                    newHighlights.append(highlight)
                }
                else {
                    highlight.adjustLength(offset: targetNSRange.length - fullNSRange.length)
                    newHighlights.append(contentsOf: highlight.split(range: newTargetRange, highlightType: .link))
                }
            }
            currentHighlights = newHighlights
            
            // Walk through the existing links, adjusting them for the text replacement.
            var newLinks = [BrowserTextLink]()
            var isAdded = false
            for link in currentLinks {
                if (link.range.location + link.range.length < fullNSRange.location) {
                    newLinks.append(link)
                }
                else {
                    if (!isAdded) {
                        newLinks.append(BrowserTextLink(range: newTargetRange, target: targetString))
                        isAdded = true
                    }
                    link.adjustLocation(offset: targetNSRange.length - fullNSRange.length)
                    newLinks.append(link)
                }
            }
            if (!isAdded) {
                newLinks.append(BrowserTextLink(range: newTargetRange, target: targetString))
                isAdded = true
            }
            currentLinks = newLinks
        }
        
        // Other highlights.
        for highlightRegex in [(regex: Regexes.StrongRegex, highlightType: BrowserTextHighlightType.bold), (regex: Regexes.ItalicsRegex, highlightType: BrowserTextHighlightType.italics)] {
            let regex = highlightRegex.regex
            let highlightType = highlightRegex.highlightType
            let matches = regex.matches(in: currentText, options: [], range: NSRange(location: 0, length: currentNSString.length))
            var currentOffset = 0
            for match in matches {
                let adjustedMatch = match.adjustingRanges(offset: currentOffset)
                let fullNSRange = adjustedMatch.range(at: 0)
                let escapeCharactersRange = adjustedMatch.range(at: 1)
                let targetNSRange = NSRange(location: fullNSRange.location + escapeCharactersRange.length, length: fullNSRange.length - 2 * escapeCharactersRange.length)
                currentOffset = currentOffset + targetNSRange.length - fullNSRange.length
                
                // First, replace the text at full range by the text at target range.
                // Add a link with the range and target.
                // Set up the highlight.
                let targetString = currentNSString.substring(with: targetNSRange)
                currentText = currentNSString.replacingCharacters(in: fullNSRange, with: targetString)
                currentNSString = currentText as NSString
                
                // Walk through the highlights, adjusting them for the text replacement and for the highlight.
                var newHighlights = [BrowserTextHighlight]()
                let newTargetRange = NSRange(location: fullNSRange.location, length: targetNSRange.length)
                for highlight in currentHighlights {
                    if highlight.range.location + highlight.range.length < fullNSRange.location {
                        newHighlights.append(highlight)
                    }
                    else if (highlight.range.location > fullNSRange.location + fullNSRange.length) {
                        highlight.adjustLocation(offset: targetNSRange.length - fullNSRange.length)
                        newHighlights.append(highlight)
                    }
                    else {
                        highlight.adjustLength(offset: targetNSRange.length - fullNSRange.length)
                        newHighlights.append(contentsOf: highlight.split(range: newTargetRange, highlightType: highlightType))
                    }
                }
                currentHighlights = newHighlights
                
                // Walk through the existing links, adjusting them for the text replacement.
                var newLinks = [BrowserTextLink]()
                for link in currentLinks {
                    if (link.range.location + link.range.length < fullNSRange.location) {
                        newLinks.append(link)
                    }
                    else {
                        link.adjustLocation(offset: targetNSRange.length - fullNSRange.length)
                        newLinks.append(link)
                    }
                }
                currentLinks = newLinks
            }
        }
        
        // Bullet points.
        let bulletMatches = Regexes.BulletRegex.matches(in: currentText, options: [], range: NSRange(location: 0, length: currentNSString.length))
        currentOffset = 0
        for bulletMatch in bulletMatches {
            let adjustedMatch = bulletMatch.adjustingRanges(offset: currentOffset)
            let matchedLocation = adjustedMatch.range.location
            let replacementString = "  \u{2022}" // two spaces and then bullet point glyph
            let offset = (replacementString as NSString).length - 1
            currentOffset += offset
            currentText = currentNSString.replacingCharacters(in: NSRange(location: matchedLocation, length: 1), with: replacementString)
            currentNSString = currentText as NSString
            // Walk through the highlights, adjusting them for the text replacement and for the highlight.
            var newHighlights = [BrowserTextHighlight]()
            for highlight in currentHighlights {
                if highlight.range.location + highlight.range.length < matchedLocation {
                    newHighlights.append(highlight)
                }
                else if highlight.range.location <= matchedLocation {
                    highlight.adjustLength(offset: offset)
                    newHighlights.append(highlight)
                }
                else {
                    highlight.adjustLocation(offset: offset)
                    newHighlights.append(highlight)
                }
            }
            currentHighlights = newHighlights
            
            // Walk through the existing links, adjusting them for the text replacement.
            var newLinks = [BrowserTextLink]()
            for link in currentLinks {
                if link.range.location < matchedLocation {
                    newLinks.append(link)
                }
                else {
                    link.adjustLocation(offset: offset)
                    newLinks.append(link)
                }
            }
            currentLinks = newLinks
        }
        
        // All done.
        _text = currentText
        _highlights = currentHighlights
        _links = currentLinks
    }
}
