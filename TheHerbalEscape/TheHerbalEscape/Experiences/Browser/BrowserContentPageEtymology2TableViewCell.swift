//
//  BrowserContentPageEtymology2TableViewCell.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 26/11/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import UIKit

class BrowserContentPageEtymology2TableViewCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet weak var word1Label: UILabel!
    @IBOutlet weak var word2Label: UILabel!
    @IBOutlet weak var etymology1Label: UILabel!
    @IBOutlet weak var etymology2Label: UILabel!
    
    // MARK: - Properties
    var etymology: BrowserPageEtymology? {
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
        if let etymology = etymology {
            // Word 1.
            let word1AttributedString = NSMutableAttributedString(string: etymology.Phrase1.Word)
            let word1Range = NSRange(location: 0, length: etymology.Phrase1.Word.count)
            word1AttributedString.addAttribute(.font, value: UIFont(name: FontNames.PerpetuaItalic, size: FontSizes.h2)!, range: word1Range)
            word1AttributedString.addAttribute(.foregroundColor, value: Colors.DarkRed, range: word1Range)
            word1AttributedString.addAttribute(.underlineStyle, value: 1, range: word1Range)
            word1AttributedString.addAttribute(.underlineColor, value: Colors.Green, range: word1Range)
            word1Label.attributedText = word1AttributedString
            word1Label.textAlignment = .right
            
            // Word 2.
            let word2AttributedString = NSMutableAttributedString(string: etymology.Phrase2!.Word)
            let word2Range = NSRange(location: 0, length: etymology.Phrase2!.Word.count)
            word2AttributedString.addAttribute(.font, value: UIFont(name: FontNames.PerpetuaItalic, size: FontSizes.h2)!, range: word2Range)
            word2AttributedString.addAttribute(.foregroundColor, value: Colors.DarkRed, range: word2Range)
            word2AttributedString.addAttribute(.underlineStyle, value: 1, range: word2Range)
            word2AttributedString.addAttribute(.underlineColor, value: Colors.Purple, range: word2Range)
            word2Label.attributedText = word2AttributedString
            word2Label.textAlignment = .left
            
            // Etymology 1
            etymology1Label.text = etymology.Phrase1.Etymology
            etymology1Label.font = UIFont(name: FontNames.Perpetua, size: FontSizes.small)
            etymology1Label.textAlignment = .center
            etymology1Label.numberOfLines = 0
            etymology1Label.lineBreakMode = .byWordWrapping
            
            // Etymology 2
            etymology2Label.text = etymology.Phrase2!.Etymology
            etymology2Label.font = UIFont(name: FontNames.Perpetua, size: FontSizes.small)
            etymology2Label.textAlignment = .center
            etymology2Label.numberOfLines = 0
            etymology2Label.lineBreakMode = .byWordWrapping
        }
    }
}
