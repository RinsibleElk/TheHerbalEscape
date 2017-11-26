//
//  BrowserContentPageHeadingTableViewCell.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 26/11/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import UIKit

class BrowserContentPageHeadingTableViewCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet weak var headingTextLabel: UILabel!
    
    // MARK: - Properties
    var heading : BrowserPageHeading? {
        didSet {
            setUpView()
        }
    }
    
    // MARK: - Overrides
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        setUpView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    // MARK: - Private functions
    private func setUpView() {
        if (heading != nil) {
            headingTextLabel.text = heading?.Text.uppercased()
            headingTextLabel.font = UIFont(name: FontNames.PerpetuaBold, size: FontSizes.h1)
            headingTextLabel.textColor = Colors.DarkForestGreen
        }
    }
}
