//
//  String.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 02/12/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import Foundation

extension String {
    
    subscript (r: CountableClosedRange<Int>) -> String {
        get {
            let startIndex =  self.index(self.startIndex, offsetBy: r.lowerBound)
            let endIndex = self.index(startIndex, offsetBy: r.upperBound - r.lowerBound)
            return String(self[startIndex...endIndex])
        }
    }
    
    func nsRange(from range: Range<Index>) -> NSRange {
        return NSRange(range, in: self)
    }
    
    func nsRange(of string: String, options: CompareOptions = .literal, range: Range<Index>? = nil, locale: Locale? = nil) -> NSRange? {
        guard let range = self.range(of: string, options: options, range: range ?? startIndex..<endIndex, locale: locale ?? .current) else { return nil }
        return NSRange(range, in: self)
    }
}
