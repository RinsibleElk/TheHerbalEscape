//
//  CAGradientLayerExtensions.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 07/12/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import UIKit

/// From https://stackoverflow.com/questions/30884170/how-can-i-set-the-uinavigationbar-with-gradient-color
extension CAGradientLayer {
    
    convenience init(frame: CGRect, colors: [UIColor]) {
        self.init()
        self.frame = frame
        self.colors = []
        for color in colors {
            self.colors?.append(color.cgColor)
        }
        startPoint = CGPoint(x: 0, y: 0)
        endPoint = CGPoint(x: 0, y: 1)
    }
    
    func creatGradientImage() -> UIImage? {
        
        var image: UIImage? = nil
        UIGraphicsBeginImageContext(bounds.size)
        if let context = UIGraphicsGetCurrentContext() {
            render(in: context)
            image = UIGraphicsGetImageFromCurrentImageContext()
        }
        UIGraphicsEndImageContext()
        return image
    }
    
}
