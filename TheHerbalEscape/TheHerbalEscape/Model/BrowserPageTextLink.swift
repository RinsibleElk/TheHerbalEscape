//
//  BrowserPageTextLink.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 26/11/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import Foundation

/// Preprocessed text can contain links (either hyperlinks or within the application).
public class BrowserPageTextLink: Codable {
    /// The range in the text where the link exists.
    var Range : NSRange
    
    /// The text of the link target.
    var Target : String
    
    init(range: NSRange, target: String) {
        Range = range
        Target = target
    }
}
