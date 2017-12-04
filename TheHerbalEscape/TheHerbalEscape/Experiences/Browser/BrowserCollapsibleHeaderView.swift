//
//  BrowserCollapsibleHeaderView.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 03/12/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import UIKit

class BrowserCollapsibleHeaderView: UITableViewHeaderFooterView {
    // MARK: - Properties
    var Index : Int = 0
    weak var delegate : CollapsibleTableViewHeaderDelegate?
    let titleLabel = UILabel()
    let arrowLabel = UILabel()

    // MARK: - Initializers
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        // Content View
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(BrowserCollapsibleHeaderView.tapHeader)))
        contentView.backgroundColor = Colors.DarkForestGreen
        
        let marginGuide = contentView.layoutMarginsGuide
        
        // Arrow label
        contentView.addSubview(arrowLabel)
        arrowLabel.textColor = UIColor.white
        arrowLabel.translatesAutoresizingMaskIntoConstraints = false
        arrowLabel.widthAnchor.constraint(equalToConstant: 12).isActive = true
        arrowLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        arrowLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        arrowLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        
        // Title label
        contentView.addSubview(titleLabel)
        titleLabel.textColor = UIColor.white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - API
    func setCollapsed(collapsed: Bool) {
        // Animate the arrow rotation (see Extensions.swf)
        arrowLabel.rotate(collapsed ? 0.0 : .pi / 2)
    }
    
    // MARK: - Tap
    @objc func tapHeader(_ gestureRecognizer: UITapGestureRecognizer) {
        guard let cell = gestureRecognizer.view as? BrowserCollapsibleHeaderView else {
            return
        }
        delegate?.toggleSection(header: self, section: cell.Index)
    }
}
