//
//  BrowserContentPageImageTableViewCell.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 26/11/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import UIKit

class BrowserContentPageImageTableViewCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet weak var photoImageView: UIImageView!
    
    // MARK: - Properties
    var imageElement : BrowserImage? {
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
        if (imageElement != nil) {
            photoImageView.image = UIImage(named: imageElement!.ImageName)
            photoImageView.accessibilityHint = imageElement!.ImageDescription
        }
    }
}
