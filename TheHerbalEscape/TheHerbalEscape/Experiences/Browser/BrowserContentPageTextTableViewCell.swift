//
//  BrowserContentPageTextTableViewCell.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 26/11/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import UIKit

class BrowserContentPageTextTableViewCell: UITableViewCell, LinkHandlerClient {
    // MARK: - Outlets
    @IBOutlet weak var elementTextView: UITextView!
    
    // MARK: - Properties
    private weak var linkHandler : LinkHandler!
    var paragraph: BrowserTextParagraph? {
        didSet {
            setUpView()
        }
    }
    
    // MARK: - LinkHandlerClient
    func setLinkHandler(linkHandler: LinkHandler) {
        self.linkHandler = linkHandler
    }
    
    // MARK: - UITapGestureRecogniser
    @objc func handleTap(sender: UITapGestureRecognizer) {
        if (paragraph?.links.count ?? 0) == 0 {
            return
        }
        guard let view = sender.view else {
            return
        }
        guard let textView = view as? UITextView else {
            return
        }
        let location = sender.location(in: view)
        guard let characterLocation = textView.characterIndexAtPosition(tapLocation: location) else {
            return
        }
        for link in paragraph!.links {
            if link.range.contains(characterLocation) {
                linkHandler!.handleLink(linkText: link.target, content: nil)
            }
        }
    }
    
    // MARK: - Overrides
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        elementTextView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(BrowserContentPageTextTableViewCell.handleTap)))
        setUpView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    // MARK: - Private functions
    private func setUpView() {
        if (paragraph != nil) {
            let textAttributedString = NSMutableAttributedString(string: paragraph!.text)
            let font = UIFont.preferredFont(forTextStyle: .body)
            let fontSize = font.pointSize
            let fontDescriptor = font.fontDescriptor
            for highlight in paragraph!.highlights {
                var highlightFontDescriptor = fontDescriptor
                var color = Colors.Black
                if (highlight.highlightTypes.contains(.link)) {
                    color = Colors.Blue
                }
                if (highlight.highlightTypes.contains(.bold)) {
                    highlightFontDescriptor = highlightFontDescriptor.withSymbolicTraits(.traitBold)!
                }
                if (highlight.highlightTypes.contains(.italics)) {
                    highlightFontDescriptor = highlightFontDescriptor.withSymbolicTraits(.traitItalic)!
                }
                textAttributedString.addAttribute(.foregroundColor, value: color, range: highlight.range)
                let highlightedFont = UIFont(descriptor: highlightFontDescriptor, size: fontSize)
                textAttributedString.addAttribute(.font, value: highlightedFont, range: highlight.range)
            }
            
            // All done.
            elementTextView.attributedText = textAttributedString
        }
    }
}
