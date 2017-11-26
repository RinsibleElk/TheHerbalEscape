//
//  TextUtilities.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 25/11/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import UIKit

public typealias TextAttributes = [String: AnyObject]

internal func fontWithTraits(traits: UIFontDescriptorSymbolicTraits, font: UIFont) -> UIFont {
    let combinedTraits = UIFontDescriptorSymbolicTraits(rawValue: font.fontDescriptor.symbolicTraits.rawValue | (traits.rawValue & 0xFFFF))
    let descriptor = font.fontDescriptor.withSymbolicTraits(combinedTraits)
    if (descriptor != nil) {
        return UIFont(descriptor: descriptor!, size: font.pointSize)
    }
    return font
}

internal func regexFromPattern(pattern: String) -> NSRegularExpression {
    do {
        return try NSRegularExpression(pattern: pattern, options: .anchorsMatchLines)
    } catch let error {
        fatalError("Error constructing regular expression: \(error)")
    }
}

internal func enumerateMatches(regex: NSRegularExpression, string: String, block: (NSTextCheckingResult) -> Void) {
    let range = NSRange(location: 0, length: (string as NSString).length)
    regex.enumerateMatches(in: string, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: range) { (result, _, _) in
        if let result = result {
            block(result)
        }
    }
}
