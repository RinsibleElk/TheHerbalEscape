//
//  UINavigationControllerExtensions.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 07/12/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import UIKit

/// From https://stackoverflow.com/questions/30884170/how-can-i-set-the-uinavigationbar-with-gradient-color
extension UINavigationBar {
    
    func setGradientBackground(colors: [UIColor]) {
        
        var updatedFrame = bounds
        updatedFrame.size.height += 20
        let gradientLayer = CAGradientLayer(frame: updatedFrame, colors: colors)
        
        setBackgroundImage(gradientLayer.creatGradientImage(), for: UIBarMetrics.default)
    }
}
