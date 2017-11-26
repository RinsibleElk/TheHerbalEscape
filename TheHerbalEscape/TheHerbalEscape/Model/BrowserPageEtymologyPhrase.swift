//
//  BrowserPageEtymologyPhrase.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 25/11/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import Foundation

/// A component of an etymology, defining one distinct word or sub-phrase.
public class BrowserPageEtymologyPhrase: Codable {
    /// The (presumably foreign) word or phrase.
    var Word : String
    
    /// The etymology.
    var Etymology : String
    
    init(word: String, etymology: String) {
        Word = word
        Etymology = etymology
    }
}
