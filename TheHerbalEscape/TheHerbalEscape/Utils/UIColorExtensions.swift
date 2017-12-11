//
//  UIColorExtensions.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 09/12/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import UIKit

extension UIColor {
    /// Initialize UIColors in a slightly less odd way than apple like to do it.
    convenience init(rgb:UInt, alpha:CGFloat = 1.0) {
        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
}

