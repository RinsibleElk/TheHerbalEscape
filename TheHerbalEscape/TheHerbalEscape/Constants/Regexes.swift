//
//  Regexes.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 25/11/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import Foundation

struct Regexes {
    static let LinkRegex = regexFromPattern(pattern: "\\[([^\\[]+)\\]\\([ \t]*<?(.*?)>?[ \t]*((['\"])(.*?)\\4)?\\)")
    static let ParagraphsRegex = regexFromPattern(pattern: "\\n\\n")
    static let StrongRegex = regexFromPattern(pattern: "(\\*\\*|__)(?=\\S)(?:.+?[*_]*)(?<=\\S)\\1")
    static let ItalicsRegex = regexFromPattern(pattern: "(\\*|_)(?=\\S)(.+?)(?<=\\S)\\1")
    static let BulletRegex = regexFromPattern(pattern: "^(\\*|-) .*")
}
