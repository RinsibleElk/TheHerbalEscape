//
//  BrowserTableViewCell.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 25/11/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import UIKit

/// The view for a cell in the table view.
class BrowserTableViewCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet weak var browsableImageView: UIImageView!
    @IBOutlet weak var browsableTitleView: UILabel!
    
    // MARK: - Properties
    var browsable : Browsable? {
        didSet {
            var image = UIImage(named: browsable!.BrowsableImage)
            if (image == nil) {
                image = #imageLiteral(resourceName: "noImage")
            }
            else {
                browsableImageView.image = image
            }
            browsableTitleView.text = browsable?.BrowsableTitle
        }
    }
    
    // MARK: - Overrides
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
