//
//  FlashcardViewController.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 18/12/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import UIKit
import PureLayout

@IBDesignable class FlashcardViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    @IBOutlet weak var flashcardImage: UIImageView!
    @IBOutlet weak var flashcardLabel: UILabel!
    @IBOutlet weak var flashcardView: UIView!
    @IBOutlet weak var flashcardWithImageView: UIView!
    @IBOutlet weak var flashcardWithImageLabel: UILabel!

    // MARK: - Properties
    var flashcardSide: FlashcardSide? = nil {
        didSet {
            if (isViewLoaded && flashcardSide != nil) {
                if (flashcardSide?.ImageName != nil) {
                    flashcardImage.image = UIImage(named: flashcardSide!.ImageName!)
                }
                else {
                    flashcardImage.image = nil
                }
                flashcardLabel.text = flashcardSide!.Text
                flashcardWithImageLabel.text = flashcardSide!.Text
                let backgroundColor = flashcardSide!.Color.getUiColor()
                flashcardView.backgroundColor = backgroundColor
                topLabel.text = flashcardSide!.Question
                bottomLabel.text = nil
                setupViews()
            }
        }
    }
    
    // MARK: - Private methods
    private func setupViews() {
        if flashcardImage.image != nil && traitCollection.verticalSizeClass == .regular {
            flashcardWithImageView.isHidden = false
            flashcardLabel.isHidden = true
        }
        else {
            flashcardWithImageView.isHidden = true
            flashcardLabel.isHidden = false
        }
    }
    
    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.layer.borderWidth = 3
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.cornerRadius = 30
        view.layer.masksToBounds = true
        view.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMaxXMinYCorner,.layerMinXMaxYCorner,.layerMinXMinYCorner]
        
        // Bootstrap AutoLayout
        view.setNeedsUpdateConstraints()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setupViews()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
