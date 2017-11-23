//
//  BrowseTableViewCell.swift
//  Playpen
//
//  Created by Oliver Samson on 23/11/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import UIKit

class BrowseTableViewCell: UITableViewCell {
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var definitionLabel: UILabel!
    var learnable : Learnable!
    
    func setLearnable(newLearnable: Learnable) {
        learnable = newLearnable
        photoImageView.image = learnable.image
        definitionLabel.text = "\(learnable.title) / \(learnable.translation)"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
