//
//  UIView.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 04/12/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import UIKit

extension UIView {
    
    func rotate(_ toValue: CGFloat, duration: CFTimeInterval = 0.2) {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        
        animation.toValue = toValue
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        
        self.layer.add(animation, forKey: nil)
    }
    
}
