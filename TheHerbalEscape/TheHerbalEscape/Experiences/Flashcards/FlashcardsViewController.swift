//
//  FlashcardsViewController.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 27/11/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import UIKit

class FlashcardsViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var safeView: UIView!
    @IBOutlet weak var veryEasy: UIImageView!
    @IBOutlet weak var easy: UIImageView!
    @IBOutlet weak var hard: UIImageView!
    @IBOutlet weak var veryHard: UIImageView!
    
    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
