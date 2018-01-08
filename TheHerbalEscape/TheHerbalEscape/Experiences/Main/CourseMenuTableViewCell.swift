//
//  CourseMenuTableViewCell.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 31/12/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import UIKit

class CourseMenuTableViewCell: UITableViewCell {
    // MARK: - Properties
    var course: String? {
        didSet {
            setText()
        }
    }
    var progress: ProgressSummary? {
        didSet {
            setText()
        }
    }

    // MARK: - Outlets
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var titleLabelView: UILabel!
    @IBOutlet weak var progressControl: ProgressControl!
    
    // MARK: - Private functions
    private func setText() {
        if course != nil {
            titleLabelView.text = course!
            if progress != nil {
                progressControl.numberAchieved = Int(progress!.Percentage * 4.0)
            }
            else {
                progressControl.numberAchieved = 0
            }
        }
        else {
            titleLabelView.text = "All"
            progressControl.numberAchieved = 0
        }
    }

    // MARK: - Overrides
    override func awakeFromNib() {
        super.awakeFromNib()

        // Initialization code
        setText()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        backgroundImageView.isHighlighted = selected
    }
}
