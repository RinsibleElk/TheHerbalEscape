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
    @IBOutlet weak var progressControl: CircularProgressControl!
    @IBOutlet weak var progressLabel: UILabel!
    
    // MARK: - Private functions
    private func setText() {
        if course != nil {
            titleLabelView.text = course!
            let progressPercentage = progress != nil ? Int(progress!.Percentage * 100.0) : 0
            progressLabel.text = "\(progressPercentage)%"
            progressControl.percentageAchieved = progressPercentage
        }
        else {
            titleLabelView.text = "All"
            let progressPercentage = 0
            progressLabel.text = "\(progressPercentage)%"
            progressControl.percentageAchieved = progressPercentage
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
