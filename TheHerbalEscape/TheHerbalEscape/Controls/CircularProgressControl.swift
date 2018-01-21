//
//  CircularProgressControl.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 21/01/2018.
//  Copyright © 2018 Oliver Samson. All rights reserved.
//

import UIKit

@IBDesignable class CircularProgressControl: UIView {
    @IBInspectable var minThickness: CGFloat = 1.0 {
        didSet {
            if minThickness != oldValue {
                setNeedsDisplay()
            }
        }
    }
    
    @IBInspectable var maxThickness: CGFloat = 3.0 {
        didSet {
            if maxThickness != oldValue {
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
    
    @IBInspectable var numSections: Int = 10 {
        didSet {
            if numSections != oldValue {
                setNeedsDisplay()
            }
        }
    }
    
    override func draw(_ rect: CGRect) {
        let height = bounds.height
        let width = bounds.width
        let center = CGPoint(x: width/2.0, y: height/2.0)
        let radius = min(height/2.0, width/2.0) - maxThickness
        let doubleNumSections = Double(numSections)
        let doubleMaxThickness = Double(maxThickness)
        let doubleMinThickness = Double(minThickness)
        for i in 1...numSections {
            let arcThickness = doubleMinThickness + (Double(i)) * ((doubleMaxThickness - doubleMinThickness) / doubleNumSections)
            var arcStartAngle = 1.8 * (Double(i - 1)/doubleNumSections) + 0.6
            if arcStartAngle > 2 {
                arcStartAngle -= 2
            }
            var arcEndAngle = 1.8 * (Double(i)/doubleNumSections) + 0.6
            if arcEndAngle > 2 {
                arcEndAngle -= 2
            }
            let minPct = Int(Double(i - 1) * 100.0 / doubleNumSections)
            let maxPct = Int(Double(i) * 100.0 / doubleNumSections)
            if percentageAchieved <= minPct {
                let circlePath = UIBezierPath(arcCenter: center, radius: radius, startAngle: CGFloat(Double.pi * arcStartAngle), endAngle:CGFloat(Double.pi * arcEndAngle), clockwise: true)
                let shapeLayer = CAShapeLayer()
                shapeLayer.path = circlePath.cgPath
                //change the fill color
                shapeLayer.fillColor = UIColor.clear.cgColor
                //you can change the stroke color
                shapeLayer.strokeColor = notAchievedColor.cgColor
                //you can change the line width
                shapeLayer.lineWidth = CGFloat(arcThickness)
                layer.addSublayer(shapeLayer)
            }
            else if percentageAchieved >= maxPct {
                let circlePath = UIBezierPath(arcCenter: center, radius: radius, startAngle: CGFloat(Double.pi * arcStartAngle), endAngle:CGFloat(Double.pi * arcEndAngle), clockwise: true)
                let shapeLayer = CAShapeLayer()
                shapeLayer.path = circlePath.cgPath
                //change the fill color
                shapeLayer.fillColor = UIColor.clear.cgColor
                //you can change the stroke color
                shapeLayer.strokeColor = achievedColor.cgColor
                //you can change the line width
                shapeLayer.lineWidth = CGFloat(arcThickness)
                layer.addSublayer(shapeLayer)
            }
            else {
                var achievedAngle = 1.8 * (Double(percentageAchieved)/100.0) + 0.6
                if achievedAngle > 2 {
                    achievedAngle -= 2
                }
                let achievedCirclePath = UIBezierPath(arcCenter: center, radius: radius, startAngle: CGFloat(Double.pi * arcStartAngle), endAngle:CGFloat(Double.pi * achievedAngle), clockwise: true)
                let achievedShapeLayer = CAShapeLayer()
                achievedShapeLayer.path = achievedCirclePath.cgPath
                //change the fill color
                achievedShapeLayer.fillColor = UIColor.clear.cgColor
                //you can change the stroke color
                achievedShapeLayer.strokeColor = achievedColor.cgColor
                //you can change the line width
                achievedShapeLayer.lineWidth = CGFloat(arcThickness)
                layer.addSublayer(achievedShapeLayer)
                let notAchievedCirclePath = UIBezierPath(arcCenter: center, radius: radius, startAngle: CGFloat(Double.pi * achievedAngle), endAngle:CGFloat(Double.pi * arcEndAngle), clockwise: true)
                let notAchievedShapeLayer = CAShapeLayer()
                notAchievedShapeLayer.path = notAchievedCirclePath.cgPath
                //change the fill color
                notAchievedShapeLayer.fillColor = UIColor.clear.cgColor
                //you can change the stroke color
                notAchievedShapeLayer.strokeColor = notAchievedColor.cgColor
                //you can change the line width
                notAchievedShapeLayer.lineWidth = CGFloat(arcThickness)
                layer.addSublayer(notAchievedShapeLayer)
            }
        }
    }

}
