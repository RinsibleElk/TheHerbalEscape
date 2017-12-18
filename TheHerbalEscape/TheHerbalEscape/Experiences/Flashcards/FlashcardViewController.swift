//
//  FlashcardViewController.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 18/12/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import UIKit

@IBDesignable class FlashcardViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    @IBOutlet weak var flashcardImage: UIImageView!
    @IBOutlet weak var flashcardLabel: UILabel!
    @IBOutlet weak var flashcardView: UIView!
    
    // MARK: - Properties
    var flashcardSide: FlashcardSide? = nil {
        didSet {
            if (isViewLoaded && flashcardSide != nil) {
                if (flashcardSide?.ImageName != nil) {
                    flashcardImage.image = UIImage(named: flashcardSide!.ImageName!)
                    flashcardImage.isHidden = false
                }
                else {
                    flashcardImage.isHidden = true
                }
                flashcardLabel.text = flashcardSide!.Text
                let backgroundColor = flashcardSide!.Color.getUiColor()
                flashcardView.backgroundColor = backgroundColor
                topLabel.text = flashcardSide!.Question
                bottomLabel.text = nil
            }
        }
    }
    
    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.layer.borderWidth = 3
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.cornerRadius = 30
        view.layer.masksToBounds = true
        view.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMaxXMinYCorner,.layerMinXMaxYCorner,.layerMinXMinYCorner]
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
