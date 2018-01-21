//
//  FlashcardsViewController.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 27/11/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import UIKit

class FlashcardsViewController: UIViewController, UIGestureRecognizerDelegate {
    // MARK: - Outlets
    @IBOutlet weak var undoButton: UIBarButtonItem!
    @IBOutlet weak var safeView: UIView!
    @IBOutlet weak var veryEasy: UIImageView!
    @IBOutlet weak var easy: UIImageView!
    @IBOutlet weak var hard: UIImageView!
    @IBOutlet weak var veryHard: UIImageView!
    @IBOutlet weak var flashcard1: UIView!
    @IBOutlet weak var flashcard2: UIView!
    @IBOutlet weak var flashcardPlaceholderView: UIView!
    var flashcardSession: IFlashcardSession!
    var flashcardVc1: FlashcardViewController?
    var flashcardVc2: FlashcardViewController?
    var showingFrontSide = true
    var showingCard1 = true
    var isAnimating = false
    var animator: UIDynamicAnimator!
    var snapBehavior: UISnapBehavior?
    var snapPoint: CGPoint?
    @IBOutlet var panGesture: UIPanGestureRecognizer!
    @IBOutlet var swipeRightGesture: UISwipeGestureRecognizer!
    @IBOutlet var swipeLeftGesture: UISwipeGestureRecognizer!
    @IBOutlet var swipeUpGesture: UISwipeGestureRecognizer!
    @IBOutlet var swipeDownGesture: UISwipeGestureRecognizer!
    @IBOutlet var tapGesture: UITapGestureRecognizer!
    @IBOutlet weak var resultsView: UIView!
    @IBOutlet weak var veryEasyResultsLabel: UILabel!
    @IBOutlet weak var easyResultsLabel: UILabel!
    @IBOutlet weak var hardResultsLabel: UILabel!
    @IBOutlet weak var veryHardResultsLabel: UILabel!
    @IBOutlet weak var helpToolbarButton: UIBarButtonItem!
    @IBOutlet weak var helpView: UIView!
    var showHelp: Bool = false {
        didSet {
            if showHelp != oldValue {
                if showHelp {
                    helpView.isHidden = false
                    if showingCard1 {
                        flashcard1.alpha = 0.3
                    }
                    else {
                        flashcard2.alpha = 0.3
                    }
                }
                else {
                    helpView.isHidden = true
                    if showingCard1 {
                        flashcard1.alpha = 1.0
                    }
                    else {
                        flashcard2.alpha = 1.0
                    }
                }
            }
        }
    }
    
    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up session - TODO find a better way to do this.
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        if (appDelegate != nil) {
            flashcardSession = appDelegate!.progressController!.createFlashcardSession(course: nil, contentRepository: appDelegate!.contentRepository)
            if flashcardVc1 != nil {
                flashcardVc1?.flashcardSide = flashcardSession.currentFrontSide
            }
            if flashcardVc2 != nil {
                flashcardVc2?.flashcardSide = flashcardSession.currentBackSide
            }
        }
        
        // Set up gestures
        panGesture.delegate = self
        swipeRightGesture.delegate = self
        swipeLeftGesture.delegate = self
        swipeUpGesture.delegate = self
        swipeDownGesture.delegate = self
        animator = UIDynamicAnimator(referenceView: self.view)

        // Do any additional setup after loading the view.
        resultsView.isHidden = true
        helpView.isHidden = true
        flashcard1.isHidden = false
        flashcard2.isHidden = true
        setUndoEnabled(isEnabled: false)
        view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "wavy"))
        showHelp = false
        veryEasy.alpha = 0
        easy.alpha = 0
        hard.alpha = 0
        veryHard.alpha = 0
        helpToolbarButton.isEnabled = true

        // Bootstrap Auto Layout
        view.setNeedsUpdateConstraints()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        // Get the new view controller using segue.destinationViewController.
        if segue.identifier == SegueIdentifiers.Flashcard1Identifier {
            flashcardVc1 = segue.destination as? FlashcardViewController
        }
        else if segue.identifier == SegueIdentifiers.Flashcard2Identifier {
            flashcardVc2 = segue.destination as? FlashcardViewController
        }
        else if !flashcardSession.hasMoreFlashcardsToShow && !flashcardSession.progressSaved {
            setUndoEnabled(isEnabled: false)
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            if (appDelegate != nil) {
                flashcardSession.save(progressController: appDelegate!.progressController!)
            }
        }
    }

    // MARK: - UIGestureRecognizerDelegate
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if (gestureRecognizer == panGesture) {
            return (otherGestureRecognizer == swipeDownGesture) || (otherGestureRecognizer == swipeUpGesture) || (otherGestureRecognizer == swipeLeftGesture) || (otherGestureRecognizer == swipeRightGesture)
        }
        return false
    }
    
    // MARK: - Private functions
    private func setUndoEnabled(isEnabled: Bool) {
        undoButton.isEnabled = isEnabled
    }
    private func setupResultsView() {
        veryEasyResultsLabel.text = "\(flashcardSession.veryEasyCount)"
        easyResultsLabel.text = "\(flashcardSession.easyCount)"
        veryHardResultsLabel.text = "\(flashcardSession.veryHardCount)"
        hardResultsLabel.text = "\(flashcardSession.hardCount)"
        resultsView.isHidden = false
        flashcard1.isHidden = true
        flashcard2.isHidden = true
        helpToolbarButton.isEnabled = false
    }

    // MARK: - Gestures
    private func handleSwipeAnimation(difficulty: FlashcardDifficulty, showEmoticons: Bool) {
        let frontView = showingCard1 ? flashcard1 : flashcard2
        let frontVc = showingCard1 ? flashcardVc1 : flashcardVc2
        let backView = flashcardSession.hasMoreFlashcardsToShow ? (showingCard1 ? flashcard2 : flashcard1) : nil
        let backVc = flashcardSession.hasMoreFlashcardsToShow ? (showingCard1 ? flashcardVc2 : flashcardVc1) : nil
        if flashcardSession.hasMoreFlashcardsToShow {
            backVc?.flashcardSide = flashcardSession.currentFrontSide
        }
        
        // Set up final frame of the back view
        let finalBackFrame = flashcardPlaceholderView.frame
        
        // Set up initial frame of the back view
        var initialBackFrame: CGRect? = nil
        switch difficulty {
        case .veryEasy:
            initialBackFrame = CGRect(x: finalBackFrame.minX, y: finalBackFrame.maxY + 50, width: finalBackFrame.width, height: finalBackFrame.height)
        case .easy:
            initialBackFrame = CGRect(x: finalBackFrame.minX - finalBackFrame.width - 50, y: finalBackFrame.minY, width: finalBackFrame.width, height: finalBackFrame.height)
        case .hard:
            initialBackFrame = CGRect(x: finalBackFrame.minX, y: finalBackFrame.minY - finalBackFrame.height - 50, width: finalBackFrame.width, height: finalBackFrame.height)
        case .veryHard:
            initialBackFrame = CGRect(x: finalBackFrame.maxX + 50, y: finalBackFrame.minY, width: finalBackFrame.width, height: finalBackFrame.height)
        }
        
        // Set up final frame of the front view
        var finalFrontFrame: CGRect? = nil
        switch difficulty {
        case .hard:
            finalFrontFrame = CGRect(x: finalBackFrame.minX, y: finalBackFrame.maxY + 50, width: finalBackFrame.width, height: finalBackFrame.height)
        case .veryHard:
            finalFrontFrame = CGRect(x: finalBackFrame.minX - finalBackFrame.width - 50, y: finalBackFrame.minY, width: finalBackFrame.width, height: finalBackFrame.height)
        case .veryEasy:
            finalFrontFrame = CGRect(x: finalBackFrame.minX, y: finalBackFrame.minY - finalBackFrame.height - 50, width: finalBackFrame.width, height: finalBackFrame.height)
        case .easy:
            finalFrontFrame = CGRect(x: finalBackFrame.maxX + 50, y: finalBackFrame.minY, width: finalBackFrame.width, height: finalBackFrame.height)
        }
        
        // Which emoticon to show
        var emoticonToShow: UIImageView? = nil
        var emoticonsToHide = [UIImageView]()
        if (showEmoticons) {
            switch difficulty {
            case .veryEasy:
                emoticonToShow = veryEasy
                emoticonsToHide.append(easy)
                emoticonsToHide.append(hard)
                emoticonsToHide.append(veryHard)
            case .easy:
                emoticonToShow = easy
                emoticonsToHide.append(veryEasy)
                emoticonsToHide.append(hard)
                emoticonsToHide.append(veryHard)
            case .hard:
                emoticonToShow = hard
                emoticonsToHide.append(easy)
                emoticonsToHide.append(veryEasy)
                emoticonsToHide.append(veryHard)
            case .veryHard:
                emoticonToShow = veryHard
                emoticonsToHide.append(easy)
                emoticonsToHide.append(hard)
                emoticonsToHide.append(veryEasy)
            }
        }
        
        // Run animations
        isAnimating = true
        if flashcardSession.hasMoreFlashcardsToShow {
            backView!.frame = initialBackFrame!
            backView!.isHidden = false
            UIView.animate(withDuration: 1.0,
                           animations: {
                            frontView?.frame = finalFrontFrame!
                            backView?.frame = finalBackFrame
                            emoticonToShow?.alpha = 1
                            for emoticonToHide in emoticonsToHide {
                                emoticonToHide.alpha = 0
                            }
            },
                           completion: { (finished:Bool) in
                            frontView?.isHidden = true
                            frontView?.frame = finalBackFrame
                            frontVc?.flashcardSide = self.flashcardSession.currentBackSide
                            self.showingCard1 = !self.showingCard1
                            self.showingFrontSide = true
                            UIView.animate(withDuration: 2.0, animations: {
                                emoticonToShow?.alpha = 0
                            })
                            self.isAnimating = false
            })
        }
        else {
            UIView.animate(withDuration: 1.0,
                           animations: {
                            frontView?.frame = finalFrontFrame!
                            emoticonToShow?.alpha = 1
                            for emoticonToHide in emoticonsToHide {
                                emoticonToHide.alpha = 0
                            }
            },
                           completion: { (finished:Bool) in
                            self.setupResultsView()
                            self.setUndoEnabled(isEnabled: false)
                            if (emoticonToShow != nil) {
                                UIView.animate(withDuration: 2.0, animations: {
                                    emoticonToShow?.alpha = 0
                                })
                            }
                            self.isAnimating = false
            })
        }
    }
    private func handleSwipe(difficulty: FlashcardDifficulty) {
        if (!isAnimating) {
            showHelp = false
            flashcardSession.finishCard(difficulty: difficulty)
            setUndoEnabled(isEnabled: flashcardSession.canUndo)
            handleSwipeAnimation(difficulty: difficulty, showEmoticons: true)
        }
    }

    @IBAction func swipeUp(_ sender: UISwipeGestureRecognizer) {
        handleSwipe(difficulty: .veryEasy)
    }
    @IBAction func handleTap(_ sender: UITapGestureRecognizer) {
        if !isAnimating {
            showHelp = false
            isAnimating = true
            let frontView = showingCard1 ? flashcard1 : flashcard2
            let backView = showingCard1 ? flashcard2 : flashcard1
            let transitionOptions: UIViewAnimationOptions = showingFrontSide ? [.transitionFlipFromRight, .showHideTransitionViews] : [.transitionFlipFromLeft, .showHideTransitionViews]
            UIView.transition(with: frontView!, duration: 1.0, options: transitionOptions, animations: {
                frontView!.isHidden = true
            })
            UIView.transition(with: backView!, duration: 1.0, options: transitionOptions, animations: {
                backView!.isHidden = false
            }, completion: { (finished:Bool) in
                self.isAnimating = false
            })
            showingCard1 = !showingCard1
            showingFrontSide = !showingFrontSide
        }
    }
    @IBAction func swipeRight(_ sender: UISwipeGestureRecognizer) {
        handleSwipe(difficulty: .easy)
    }
    @IBAction func swipeDown(_ sender: UISwipeGestureRecognizer) {
        handleSwipe(difficulty: .hard)
    }
    @IBAction func swipeLeft(_ sender: UISwipeGestureRecognizer) {
        handleSwipe(difficulty: .veryHard)
    }
    @IBAction func handleUndo(_ sender: UIBarButtonItem) {
        if !isAnimating && flashcardSession.canUndo {
            showHelp = false
            let lastDifficulty = flashcardSession.undo()
            setUndoEnabled(isEnabled: flashcardSession.canUndo)
            handleSwipeAnimation(difficulty: lastDifficulty.reverse(), showEmoticons: false)
        }
    }
    @IBAction func handleDrag(_ sender: UIPanGestureRecognizer) {
        showHelp = false
        let translation = sender.translation(in: self.view)
        if sender.state == .ended {
            if let view = showingCard1 ? flashcard1 : flashcard2 {
                // Either snap back or swipe a certain direction
                let veryEasyAlpha = min(1, max(0, 2.0 * (0.5 * flashcardPlaceholderView.frame.height - view.center.y) / flashcardPlaceholderView.frame.height))
                let easyAlpha = min(1, max(0, 2.0 * (view.center.x - 0.5 * flashcardPlaceholderView.frame.width) / flashcardPlaceholderView.frame.width))
                let hardAlpha = min(1, max(0, 2.0 * (view.center.y - 0.5 * flashcardPlaceholderView.frame.height) / flashcardPlaceholderView.frame.height))
                let veryHardAlpha = min(1, max(0, 2.0 * (0.5 * flashcardPlaceholderView.frame.width - view.center.x) / flashcardPlaceholderView.frame.width))
                
                // We'll swipe in the direction that has the largest alpha, if there is some momentum in that direction on release
                var difficulty: FlashcardDifficulty?
                let minAlpha: CGFloat = 0.3
                let minVelocity: CGFloat = 10.0
                if veryEasyAlpha > minAlpha && veryEasyAlpha > easyAlpha && veryEasyAlpha > hardAlpha && veryEasyAlpha > veryHardAlpha && sender.velocity(in: self.view).y < -minVelocity {
                    difficulty = FlashcardDifficulty.veryEasy
                }
                else if veryHardAlpha > minAlpha && veryHardAlpha > easyAlpha && veryHardAlpha > hardAlpha && veryHardAlpha > veryEasyAlpha && sender.velocity(in: self.view).x < -minVelocity {
                    difficulty = FlashcardDifficulty.veryHard
                }
                else if easyAlpha > minAlpha && easyAlpha > veryEasyAlpha && easyAlpha > hardAlpha && easyAlpha > veryHardAlpha && sender.velocity(in: self.view).x > minVelocity {
                    difficulty = FlashcardDifficulty.easy
                }
                else if hardAlpha > minAlpha && hardAlpha > easyAlpha && hardAlpha > veryHardAlpha && hardAlpha > veryEasyAlpha && sender.velocity(in: self.view).y > minVelocity {
                    difficulty = FlashcardDifficulty.hard
                }
                
                if difficulty != nil {
                    snapPoint = nil
                    handleSwipe(difficulty: difficulty!)
                }
                else if snapPoint != nil {
                    if snapBehavior != nil {
                        animator.removeBehavior(snapBehavior!)
                    }
                    snapBehavior = UISnapBehavior(item: view, snapTo: snapPoint!)
                    snapPoint = nil
                    snapBehavior!.damping = 1
                    animator.addBehavior(snapBehavior!)
                    UIView.animate(withDuration: 0.5, animations: {
                        self.veryEasy.alpha = 0
                        self.easy.alpha = 0
                        self.hard.alpha = 0
                        self.veryHard.alpha = 0
                    })
                }
            }
        }
        else {
            if let view = showingCard1 ? flashcard1 : flashcard2 {
                if (snapPoint == nil) {
                    // TODO: This never comes out quite central...
                    snapPoint = view.convert(view.center, to: self.view) // flashcardPlaceholderView.convert(flashcardPlaceholderView.center, to: self.view)
                }
                view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
                let veryEasyAlpha = min(1, max(0, 2.0 * (0.5 * flashcardPlaceholderView.frame.height - view.center.y) / flashcardPlaceholderView.frame.height))
                let easyAlpha = min(1, max(0, 2.0 * (view.center.x - 0.5 * flashcardPlaceholderView.frame.width) / flashcardPlaceholderView.frame.width))
                let hardAlpha = min(1, max(0, 2.0 * (view.center.y - 0.5 * flashcardPlaceholderView.frame.height) / flashcardPlaceholderView.frame.height))
                let veryHardAlpha = min(1, max(0, 2.0 * (0.5 * flashcardPlaceholderView.frame.width - view.center.x) / flashcardPlaceholderView.frame.width))
                veryEasy.alpha = veryEasyAlpha
                easy.alpha = easyAlpha
                hard.alpha = hardAlpha
                veryHard.alpha = veryHardAlpha
            }
            sender.setTranslation(CGPoint.zero, in: self.view)
        }
    }

    @IBAction func helpButtonPressed(_ sender: UIBarButtonItem) {
        if !isAnimating {
            showHelp = !showHelp
        }
    }
}
