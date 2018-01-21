//
//  CircularProgressControl.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 21/01/2018.
//  Copyright © 2018 Oliver Samson. All rights reserved.
//

import UIKit

@IBDesignable class CircularProgressControl: UIView {
    @IBInspectable var thickness: CGFloat = 3.0 {
        didSet {
            if thickness != oldValue {
                setNeedsDisplay()
            }
        }
    }
    
    @IBInspectable var notAchievedColor: UIColor = UIColor.lightGray {
        didSet {
            if notAchievedColor != oldValue {
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

    @IBInspectable var percentageAchieved: Int = 0 {
        didSet {
            if percentageAchieved != oldValue {
                setNeedsDisplay()
            }
        }
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        let height = bounds.height
        let width = bounds.width
        let center = CGPoint(x: width/2.0, y: height/2.0)
        let radius = min(height/2.0, width/2.0) - thickness
        var achievedAnglePctPi = 1.8 * (Double(percentageAchieved)/100.0) + 0.6
        if achievedAnglePctPi > 2 {
            achievedAnglePctPi -= 2
        }
        if (percentageAchieved != 100) {
            let circlePath = UIBezierPath(arcCenter: center, radius: radius, startAngle: CGFloat(Double.pi * achievedAnglePctPi), endAngle:CGFloat(Double.pi * 0.4), clockwise: true)
            let shapeLayer = CAShapeLayer()
            shapeLayer.path = circlePath.cgPath
            //change the fill color
            shapeLayer.fillColor = UIColor.clear.cgColor
            //you can change the stroke color
            shapeLayer.strokeColor = notAchievedColor.cgColor
            //you can change the line width
            shapeLayer.lineWidth = thickness
            layer.addSublayer(shapeLayer)
        }
        if (percentageAchieved != 0) {
            let circlePath = UIBezierPath(arcCenter: center, radius: radius, startAngle: CGFloat(Double.pi * 0.6), endAngle:CGFloat(Double.pi * achievedAnglePctPi), clockwise: true)
            let shapeLayer = CAShapeLayer()
            shapeLayer.path = circlePath.cgPath
            //change the fill color
            shapeLayer.fillColor = UIColor.clear.cgColor
            //you can change the stroke color
            shapeLayer.strokeColor = achievedColor.cgColor
            //you can change the line width
            shapeLayer.lineWidth = thickness
            layer.addSublayer(shapeLayer)
        }
    }

}
