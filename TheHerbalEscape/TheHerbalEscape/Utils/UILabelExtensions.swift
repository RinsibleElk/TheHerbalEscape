//
//  UILabelExtensions.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 05/12/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import UIKit

extension UILabel {
    /// Code from SO. Purpose is to take some functionality that is on UITextView and get it onto UILabel. It might be better to return to UITextView.
    /// For UITextView, this would be:
    ///   let position = textView.closestPosition(to: tapLocation)
    ///   return textView.offset(from: textView.beginningOfDocument, to: position)
    func characterIndexAtPosition(tapLocation: CGPoint) -> Int? {
        let attributedText = NSMutableAttributedString(attributedString: self.attributedText!)
        attributedText.addAttributes([NSAttributedStringKey.font: self.font], range: NSMakeRange(0, (self.attributedText?.string.count)!))
        
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize(width: (self.frame.width), height: (self.frame.height)+100))
        let textStorage = NSTextStorage(attributedString: attributedText)
        
        // Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = self.lineBreakMode
        textContainer.maximumNumberOfLines = self.numberOfLines
        let labelSize = self.bounds.size
        textContainer.size = labelSize
        
        // get the index of character where user tapped
        let indexOfCharacter = layoutManager.characterIndex(for: tapLocation, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        return indexOfCharacter
    }
}
