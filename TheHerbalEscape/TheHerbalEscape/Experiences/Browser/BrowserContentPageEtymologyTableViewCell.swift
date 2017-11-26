//
//  BrowserContentPageEtymologyTableViewCell.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 26/11/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import UIKit

class BrowserContentPageEtymologyTableViewCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var etymologyLabel: UILabel!
    
    // MARK: - Properties
    var etymology: BrowserPageEtymology? {
        didSet {
            setUpView()
        }
    }
    
    // MARK: - Overrides
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Gesture recogniser
        
        
        // Initialization code
        setUpView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Private functions
    private func setUpView() {
        if let etymology = etymology {
            // Word 1.
            let word1AttributedString = NSMutableAttributedString(string: etymology.Phrase1.Word)
            let word1Range = NSRange(location: 0, length: etymology.Phrase1.Word.count)
            word1AttributedString.addAttribute(.font, value: UIFont(name: FontNames.PerpetuaItalic, size: FontSizes.h2)!, range: word1Range)
            word1AttributedString.addAttribute(.foregroundColor, value: Colors.DarkRed, range: word1Range)
            word1AttributedString.addAttribute(.underlineStyle, value: 1, range: word1Range)
            word1AttributedString.addAttribute(.underlineColor, value: Colors.Green, range: word1Range)
            wordLabel.attributedText = word1AttributedString
            wordLabel.textAlignment = .center
            
            // Etymology 1
            etymologyLabel.text = etymology.Phrase1.Etymology
            etymologyLabel.font = UIFont(name: FontNames.Perpetua, size: FontSizes.small)
            etymologyLabel.textAlignment = .center
            etymologyLabel.numberOfLines = 0
            etymologyLabel.lineBreakMode = .byWordWrapping
        }
    }
}
