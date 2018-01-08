//
//  ProgressSection.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 08/01/2018.
//  Copyright © 2018 Oliver Samson. All rights reserved.
//

import UIKit

@IBDesignable class ProgressControl: UIView {
    // MARK: - Inspectable Properties
    @IBInspectable var numberAchieved: Int = 2 {
        didSet {
            if numberOfSections != oldValue {
                setNeedsDisplay()
            }
        }
    }
    
    @IBInspectable var numberOfSections: Int = 4 {
        didSet {
            if numberOfSections != oldValue {
                setNeedsDisplay()
            }
        }
    }
    
    @IBInspectable var spacing: CGFloat = 5.0 {
        didSet {
            if spacing != oldValue {
                setNeedsDisplay()
            }
        }
    }
    
    @IBInspectable var achievedColor: UIColor = UIColor.blue {
        didSet {
            if achievedColor != oldValue {
                setNeedsDisplay()
            }
        }
    }
    
    @IBInspectable var unachievedColor: UIColor = UIColor.lightGray {
        didSet {
            if unachievedColor != oldValue {
                setNeedsDisplay()
            }
        }
    }

    // MARK: - Draw
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        for index in 1...numberOfSections {
            let path = UIBezierPath()
            let h = bounds.height
            let n = max(1.0, CGFloat(numberOfSections))
            let i = max(1.0, min(n, CGFloat(index)))
            let s = max(0.0, spacing)
            let totalW = bounds.width
            let w = (totalW - (n - 1.0) * s) / n
            let l = (h * (i - 1.0) * (w + s)) / totalW
            let r = (h * (i - 1.0) * (w + s) + w * h) / totalW
            let x = (i - 1.0) * (w + s)
            context!.beginPath()
            path.move(to: CGPoint(x: x, y: h - l))
            path.addLine(to: CGPoint(x: x, y: h))
            path.addLine(to: CGPoint(x: x + w, y: h))
            path.addLine(to: CGPoint(x: x + w, y: h - r))
            path.addLine(to: CGPoint(x: x, y: h - l))
            path.close()
            let color = index <= numberAchieved ? achievedColor : unachievedColor
            context!.setFillColor(color.cgColor)
            path.fill()
        }
    }
}
