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
    private var linkHandler : LinkHandler!
    var textElement: BrowserPageText? {
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
        if (textElement?.Links.count ?? 0) == 0 {
            return
        }
        guard let view = sender.view else {
            return
        }
        guard let textView = view as? UITextView else {
            return
        }
        let location = sender.location(in: view)
        guard let position = textView.closestPosition(to: location) else {
            return
        }
        let characterLocation = textView.offset(from: textView.beginningOfDocument, to: position)
        for link in textElement!.Links {
            if link.Range.contains(characterLocation) {
                linkHandler!.handleLink(linkText: link.Target, content: nil)
            }
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
        if (textElement != nil) {
            let textAttributedString = NSMutableAttributedString(string: textElement!.Text)
            let textEntireRange = NSRange(location: 0, length: textElement!.Text.count)
            elementTextView.textAlignment = .left
            elementTextView.isEditable = false
            elementTextView.isScrollEnabled = false
            
            // Set up font, taking into account highlights.
            if (textElement!.Highlights.count == 0) {
                textAttributedString.addAttribute(.font, value: UIFont(name: FontNames.Perpetua, size: FontSizes.p)!, range: textEntireRange)
            }
            else {
                var currentLocation : Int = 0
                let font = UIFont(name: FontNames.Perpetua, size: FontSizes.p)!
                let boldFont = UIFont(name: FontNames.PerpetuaBold, size: FontSizes.p)!
                let italicFont = UIFont(name: FontNames.PerpetuaItalic, size: FontSizes.p)!
                for highlight in textElement!.Highlights {
                    let fontToUse = highlight.HighlightType == .bold ? boldFont : italicFont
                    if (currentLocation == highlight.Range.location) {
                        textAttributedString.addAttribute(.font, value: fontToUse, range: highlight.Range)
                        currentLocation += highlight.Range.length
                    }
                    else {
                        textAttributedString.addAttribute(.font, value: font, range: NSRange(location: currentLocation, length: highlight.Range.location - currentLocation))
                        textAttributedString.addAttribute(.font, value: fontToUse, range: highlight.Range)
                        currentLocation = highlight.Range.location + highlight.Range.length
                    }
                }
                if (currentLocation < textEntireRange.length) {
                    textAttributedString.addAttribute(.font, value: font, range: NSRange(location: currentLocation, length: textEntireRange.length - currentLocation))
                }
            }
            
            // Set up links.
            if (textElement!.Links.count == 0) {
                textAttributedString.addAttribute(.foregroundColor, value: Colors.Black, range: textEntireRange)
            }
            else {
                elementTextView.isUserInteractionEnabled = true
                let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(BrowserContentPageTextTableViewCell.handleTap(sender:)))
                elementTextView.addGestureRecognizer(tapGestureRecognizer)
                
                // Split the string up, colorize, and add the link locations.
                var currentLocation : Int = 0
                for link in textElement!.Links {
                    if (currentLocation == link.Range.location) {
                        // Probably an error on the part of the content but hey.
                        textAttributedString.addAttribute(.foregroundColor, value: Colors.Blue, range: link.Range)
                        currentLocation += link.Range.length
                    }
                    else {
                        textAttributedString.addAttribute(.foregroundColor, value: Colors.Black, range: NSRange(location: currentLocation, length: link.Range.location - currentLocation))
                        textAttributedString.addAttribute(.foregroundColor, value: Colors.Blue, range: link.Range)
                        currentLocation = link.Range.location + link.Range.length
                    }
                    //                linkViews.append((view: elementTextView, link: link))
                }
                if (currentLocation < textEntireRange.length) {
                    textAttributedString.addAttribute(.foregroundColor, value: Colors.Black, range: NSRange(location: currentLocation, length: textEntireRange.length - currentLocation))
                }
            }
            
            // All done.
            elementTextView.attributedText = textAttributedString
        }
    }
}
