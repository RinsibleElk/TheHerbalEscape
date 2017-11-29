//
//  MenuButton.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 29/11/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import UIKit
import QuartzCore

extension UIButton {
    
    func setBackgroundColor(color: UIColor, forState: UIControlState) {
        
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        UIGraphicsGetCurrentContext()!.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.setBackgroundImage(colorImage, for: forState)
    }
}

@IBDesignable class MenuButton: UIButton {
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: - Overrides
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    private func setup() {
        // Add our border here and every custom setup
        self.setBackgroundColor(color: Colors.SlightlyDarkForestGreen, forState: .selected)
        self.setBackgroundColor(color: Colors.ForestGreen, forState: .normal)
        self.titleLabel?.textColor = UIColor.white
        self.layer.cornerRadius = 5.0;
        
        self.layer.borderWidth = 2.0;
        self.layer.borderColor = UIColor.clear.cgColor
        
        self.layer.shadowColor = Colors.DarkForestGreen.cgColor
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 1.0
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
    }
}
