//
//  BulletPointListHeaderView.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 28/11/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import UIKit

class BulletPointListHeaderView: UITableViewHeaderFooterView {
    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var arrowLabel: UILabel!
    
    // MARK: - Private functions
    private func rotate(_ toValue: CGFloat, duration: CFTimeInterval = 0.2) {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.toValue = toValue
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        arrowLabel.layer.add(animation, forKey: nil)
    }

    // MARK: - Overrides
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
