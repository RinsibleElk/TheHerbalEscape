//
//  BrowserContentPageViewController.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 25/11/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import UIKit
import PureLayout

class BrowserContentPageViewController: UIViewController, LinkHandlerClient {
    // MARK: - Properties
    private var linkHandler : LinkHandler?
    var browserPage : BrowserPage!
    var sameWidthViews = [(view1:UIView, view2:UIView)]()
    var sameHeightViews = [(view1:UIView, view2:UIView)]()
    var linkViews = [(view:UITextView, link:BrowserPageTextLink)]()
    var imageViews = [UIImageView]()
    var scrollView = UIScrollView.newAutoLayout()
    var contentView = UIStackView.newAutoLayout()
    var viewConstraints : NSArray?
    var didSetupConstraints = false

    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()

        // Add the sub views.
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.axis = .vertical
        contentView.spacing = 12.0
        scrollView.isScrollEnabled = true
        for element in browserPage.Elements {
            switch element {
            case .heading(let heading):
                let headingView = UILabel()
                headingView.text = heading.Text.uppercased()
                headingView.font = UIFont(name: FontNames.PerpetuaBold, size: FontSizes.h1)
                headingView.textAlignment = .center
                headingView.textColor = Colors.DarkForestGreen
                contentView.addArrangedSubview(headingView)
            case .text(let text):
                let textView = UITextView()
                let textAttributedString = NSMutableAttributedString(string: text.Text)
                let textEntireRange = NSRange(location: 0, length: text.Text.count)
                textAttributedString.addAttribute(.font, value: UIFont(name: FontNames.Perpetua, size: FontSizes.p)!, range: textEntireRange)
                textView.textAlignment = .left
                textView.isEditable = false
                textView.isScrollEnabled = false
                if (text.Links.count == 0) {
                    textAttributedString.addAttribute(.foregroundColor, value: Colors.Black, range: textEntireRange)
                }
                else {
                    textView.isUserInteractionEnabled = true
                    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(BrowserContentPageViewController.handleTap(sender:)))
                    textView.addGestureRecognizer(tapGestureRecognizer)
                    
                    // Split the string up, colorize, and add the link locations.
                    var currentLocation : Int = 0
                    for link in text.Links {
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
                        linkViews.append((view: textView, link: link))
                    }
                    if (currentLocation < textEntireRange.length) {
                        textAttributedString.addAttribute(.foregroundColor, value: Colors.Black, range: NSRange(location: currentLocation, length: textEntireRange.length - currentLocation))
                    }
                }
                textView.attributedText = textAttributedString
                contentView.addArrangedSubview(textView)
            case .image(let image):
                let imageView = UIImageView()
                imageView.image = UIImage(named: image.ImageName)
                imageView.accessibilityHint = image.ImageDescription
                contentView.addArrangedSubview(imageView)
                imageViews.append(imageView)
            case .etymology(let etymology):
                if (etymology.Phrase2 == nil) {
                    // This is the easy one, simply set up a vertical stack view, and stick the two labels in. No extra constraints needed. Possibly constrain the width of the lower bit as a fraction of the overall?
                    let textLabel = UILabel()
                    let textAttributedString = NSMutableAttributedString(string: etymology.Phrase1.Word)
                    let textRange = NSRange(location: 0, length: etymology.Phrase1.Word.count)
                    textAttributedString.addAttribute(.font, value: UIFont(name: FontNames.PerpetuaItalic, size: FontSizes.h2)!, range: textRange)
                    textAttributedString.addAttribute(.foregroundColor, value: Colors.DarkRed, range: textRange)
                    textAttributedString.addAttribute(.underlineStyle, value: 1, range: textRange)
                    textAttributedString.addAttribute(.underlineColor, value: Colors.Green, range: textRange)
                    textLabel.attributedText = textAttributedString
                    textLabel.textAlignment = .center
                    let etymologyLabel = UILabel()
                    etymologyLabel.text = etymology.Phrase1.Etymology
                    etymologyLabel.font = UIFont(name: FontNames.Perpetua, size: FontSizes.small)
                    etymologyLabel.textAlignment = .center
                    etymologyLabel.numberOfLines = 0
                    etymologyLabel.lineBreakMode = .byWordWrapping
                    let stackView = UIStackView()
                    stackView.axis = .vertical
                    stackView.addArrangedSubview(textLabel)
                    stackView.addArrangedSubview(etymologyLabel)
                    contentView.addArrangedSubview(stackView)
                }
                else {
                    let horizontalStackView = UIStackView()
                    horizontalStackView.axis = .horizontal
                    horizontalStackView.spacing = 2
                    
                    // Word 1.
                    let text1Label = UILabel()
                    let text1AttributedString = NSMutableAttributedString(string: etymology.Phrase1.Word)
                    let text1Range = NSRange(location: 0, length: etymology.Phrase1.Word.count)
                    text1AttributedString.addAttribute(.font, value: UIFont(name: FontNames.PerpetuaItalic, size: FontSizes.h2)!, range: text1Range)
                    text1AttributedString.addAttribute(.foregroundColor, value: Colors.DarkRed, range: text1Range)
                    text1AttributedString.addAttribute(.underlineStyle, value: 1, range: text1Range)
                    text1AttributedString.addAttribute(.underlineColor, value: Colors.Green, range: text1Range)
                    text1Label.attributedText = text1AttributedString
                    text1Label.textAlignment = .right
                    
                    // Word 2.
                    let text2Label = UILabel()
                    let text2AttributedString = NSMutableAttributedString(string: etymology.Phrase2!.Word)
                    let text2Range = NSRange(location: 0, length: etymology.Phrase2!.Word.count)
                    text2AttributedString.addAttribute(.font, value: UIFont(name: FontNames.PerpetuaItalic, size: FontSizes.h2)!, range: text2Range)
                    text2AttributedString.addAttribute(.foregroundColor, value: Colors.DarkRed, range: text2Range)
                    text2AttributedString.addAttribute(.underlineStyle, value: 1, range: text2Range)
                    text2AttributedString.addAttribute(.underlineColor, value: Colors.Purple, range: text2Range)
                    text2Label.attributedText = text2AttributedString
                    text2Label.textAlignment = .left

                    // Etymology 1
                    let etymology1Label = UILabel()
                    etymology1Label.text = etymology.Phrase1.Etymology
                    etymology1Label.font = UIFont(name: FontNames.Perpetua, size: FontSizes.small)
                    etymology1Label.textAlignment = .center
                    etymology1Label.numberOfLines = 0
                    etymology1Label.lineBreakMode = .byWordWrapping

                    // Etymology 2
                    let etymology2Label = UILabel()
                    etymology2Label.text = etymology.Phrase2!.Etymology
                    etymology2Label.font = UIFont(name: FontNames.Perpetua, size: FontSizes.small)
                    etymology2Label.textAlignment = .center
                    etymology2Label.numberOfLines = 0
                    etymology2Label.lineBreakMode = .byWordWrapping
                    
                    // Layout
                    let verticalStackView1 = UIStackView()
                    verticalStackView1.axis = .vertical
                    verticalStackView1.spacing = 5
                    let verticalStackView2 = UIStackView()
                    verticalStackView1.spacing = 5
                    verticalStackView2.axis = .vertical
                    verticalStackView1.addArrangedSubview(text1Label)
                    verticalStackView1.addArrangedSubview(etymology1Label)
                    verticalStackView2.addArrangedSubview(text2Label)
                    verticalStackView2.addArrangedSubview(etymology2Label)
                    horizontalStackView.addArrangedSubview(verticalStackView1)
                    horizontalStackView.addArrangedSubview(verticalStackView2)

                    // Size constraints. Possibly want to shrink the sizes of the etymologies here. Let's see how it pans out.
                    sameWidthViews.append((view1:verticalStackView1, view2:verticalStackView2))
                    sameHeightViews.append((view1:text1Label, view2:text2Label))

                    contentView.addArrangedSubview(horizontalStackView)
                }
            }
        }
        
        // Bootstrap AutoLayout
        view.setNeedsUpdateConstraints()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        if (!didSetupConstraints) {
            viewConstraints = NSLayoutConstraint.autoCreateAndInstallConstraints {
                scrollView.autoPinEdgesToSuperviewMargins()
                contentView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 20.0, left: 0.0, bottom: 20.0, right: 0.0))
                contentView.autoMatch(.width, to: .width, of: scrollView)
                //contentView.autoMatch(.width, to: .width, of: view)
                for imgv in imageViews {
                    let multiplier = imgv.image!.size.height / imgv.image!.size.width
                    imgv.autoConstrainAttribute(.height, to: .width, of: imgv, withMultiplier: multiplier)
                }
                for equalWidths in sameWidthViews {
                    equalWidths.view1.autoMatch(.width, to: .width, of: equalWidths.view2)
                }
                for equalHeights in sameHeightViews {
                    equalHeights.view1.autoMatch(.height, to: .height, of: equalHeights.view2)
                }
            } as NSArray?
            didSetupConstraints = true
        }
    }
    
    // MARK: - Gestures
    @objc func handleTap(sender:UITapGestureRecognizer) {
        if (linkHandler != nil) {
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
            for link in linkViews {
                if link.view == textView {
                    if link.link.Range.contains(characterLocation) {
                        linkHandler!.handleLink(linkText: link.link.Target, content: nil)
                    }
                }
            }
        }
    }
    
    // MARK: - LinkHandlerClient
    func setLinkHandler(linkHandler: LinkHandler) {
        self.linkHandler = linkHandler
    }
}
