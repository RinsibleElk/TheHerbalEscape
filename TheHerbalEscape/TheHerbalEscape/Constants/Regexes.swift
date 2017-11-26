//
//  Regexes.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 25/11/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import Foundation

struct Regexes {
    // From markdown.pl v1.0.1 <http://daringfireball.net/projects/markdown/>
    static let LinkRegex = regexFromPattern(pattern: "\\[([^\\[]+)\\]\\([ \t]*<?(.*?)>?[ \t]*((['\"])(.*?)\\4)?\\)")

}
