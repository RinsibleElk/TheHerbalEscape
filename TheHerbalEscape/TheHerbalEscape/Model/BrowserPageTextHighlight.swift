//
//  BrowserPageTextHighlight.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 26/11/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import Foundation

/// Preprocessed text can contain highlights (bold, italics).
public class BrowserPageTextHighlight: Codable {
    /// The range in the text where the link exists.
    var Range : NSRange
    
    /// The type of highlight.
    var HighlightType : BrowserPageTextHighlightType
    
    init(range: NSRange, highlightType: BrowserPageTextHighlightType) {
        Range = range
        HighlightType = highlightType
    }
}
