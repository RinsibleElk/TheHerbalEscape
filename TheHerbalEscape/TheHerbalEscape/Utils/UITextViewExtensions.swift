//
//  UITextViewExtensions.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 11/12/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import Foundation

import UIKit

extension UITextView {
    func characterIndexAtPosition(tapLocation: CGPoint) -> Int? {
        guard let position = self.closestPosition(to: tapLocation) else {
            return nil
        }
        return self.offset(from: self.beginningOfDocument, to: position)
    }
}
