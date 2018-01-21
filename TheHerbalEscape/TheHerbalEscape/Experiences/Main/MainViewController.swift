//
//  MainViewController.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 29/11/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    // MARK: - Properties
    var overallProgressSummary: OverallProgressSummary?

    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        updateProgress()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier != nil {
            switch segue.identifier! {
            case SegueIdentifiers.FlashcardsMenuSegueIdentifier:
                if let destinationVc = segue.destination as? CourseMenuTableViewController {
                    destinationVc.selectionSegueIdentifier = SegueIdentifiers.FlashcardsSegueIdentifier
                    destinationVc.menuTitle = "Select Flashcards"
                    destinationVc.progress = overallProgressSummary!
                }
            default:
                if let destinationVc = segue.destination as? CourseMenuTableViewController {
                    destinationVc.selectionSegueIdentifier = SegueIdentifiers.QuizSegueIdentifier
                    destinationVc.menuTitle = "Select Quiz"
                    destinationVc.progress = overallProgressSummary!
                }
            }
        }
    }
    
    // MARK: - ProgressUpdatedDelegate
    func updateProgress() {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        if (appDelegate != nil) {
            overallProgressSummary = appDelegate!.progressController!.getProgressSummary(contentRepository: appDelegate!.contentRepository)
        }
    }
}
