//
//  BrowserPageEtymology.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 25/11/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import Foundation

/// A Browser page element representing the etymology of a foreign word or phrase.
public class BrowserPageEtymology: Codable {
    /// The split word or phrase. It is not recommended to have more than 2, perhaps 3??, sections.
    var Phrase1 : BrowserPageEtymologyPhrase
    var Phrase2 : BrowserPageEtymologyPhrase?

    init(phrase1: BrowserPageEtymologyPhrase, phrase2: BrowserPageEtymologyPhrase?) {
        Phrase1 = phrase1
        Phrase2 = phrase2
    }
}
