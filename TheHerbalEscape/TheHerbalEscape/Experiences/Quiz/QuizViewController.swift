//
//  QuizViewController.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 30/12/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import UIKit

enum QuizViewMode: Int, Codable {
    case Question1 = 1
    case Question2 = 2
    case Results = 3
}

class QuizViewController: UIViewController, IQuizQuestionDelegate {
    // MARK: - Outlets
    @IBOutlet weak var placeholderView: UIView!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var questionView1: UIView!
    @IBOutlet weak var questionView2: UIView!
    @IBOutlet weak var resultsView: UIView!
    @IBOutlet weak var browserButton: UIButton!
    @IBOutlet weak var numIncorrect: UILabel!
    @IBOutlet weak var numCorrect: UILabel!
    
    // MARK: - Properties
    var quizSession : IQuizSession?
    
    // MARK: - Private properties
    private var viewMode: QuizViewMode = .Question1
    private var questionVc1: QuizQuestionViewController?
    private var questionVc2: QuizQuestionViewController?
    private var didSetupConstraints: Bool = false
    private var v_12Constraints: NSArray?
    private var v_21Constraints: NSArray?
    private var v12_Constraints: NSArray?
    private var v21_Constraints: NSArray?
    private var vOffConstraints: NSArray?

    // MARK: - IQuizQuestionDelegate
    func tapped(answerIndex: Int) {
        quizSession!.toggleAnswer(answerIndex: answerIndex)
        updateState()
    }

    // MARK: - Private functions
    private func setupResults() {
        numCorrect.text = "\(quizSession!.numCorrect)"
        numIncorrect.text = "\(quizSession!.numIncorrect)"
        resultsView.isHidden = false
        browserButton.isEnabled = true
        continueButton.isHidden = true
        continueButton.isEnabled = false
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        if (appDelegate != nil) {
            quizSession!.save(progressController: appDelegate!.progressController!)
        }
    }
    
    private func updateState() {
        continueButton.isEnabled = quizSession!.continueEnabled
        continueButton.setTitle(quizSession!.continueText, for: [])
        if let vc = (viewMode == .Question1) ? questionVc1 : questionVc2 {
            for answerIndex in 1...4 {
                vc.setAnswerState(answerIndex: answerIndex, answerState: quizSession!.getState(answerIndex: answerIndex))
            }
        }
    }
    
    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()

        resultsView.isHidden = true
        browserButton.isEnabled = false
        continueButton.setTitle("Confirm", for: [])

        // Set up session - TODO find a better way to do this.
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        if (appDelegate != nil) {
            quizSession = appDelegate!.progressController!.createQuizSession(course: nil, contentRepository: appDelegate!.contentRepository)
            if questionVc1 != nil {
                questionVc1!.quizQuestion = quizSession!.currentQuestion
            }
        }

        view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "wavy"))
        questionView2.isHidden = true

        // Bootstrap Auto Layout
        view.setNeedsUpdateConstraints()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func updateViewConstraints() {
        if !didSetupConstraints {
            v_12Constraints =
                NSLayoutConstraint.autoCreateAndInstallConstraints {
                    questionView1.autoPinEdge(.top, to: .top, of: placeholderView)
                    questionView1.autoPinEdge(.bottom, to: .bottom, of: placeholderView)
                    questionView1.autoPinEdge(.left, to: .left, of: placeholderView)
                    questionView1.autoPinEdge(.right, to: .right, of: placeholderView)
                    questionView2.autoConstrainAttribute(.width, to: .width, of: questionView1)
                    questionView2.autoConstrainAttribute(.height, to: .height, of: questionView1)
                    questionView2.autoAlignAxis(.horizontal, toSameAxisOf: questionView1)
                    questionView2.autoPinEdge(.left, to: .right, of: questionView1, withOffset: 50)
                } as NSArray
            v_21Constraints =
                NSLayoutConstraint.autoCreateConstraintsWithoutInstalling {
                    questionView2.autoPinEdge(.top, to: .top, of: placeholderView)
                    questionView2.autoPinEdge(.bottom, to: .bottom, of: placeholderView)
                    questionView2.autoPinEdge(.left, to: .left, of: placeholderView)
                    questionView2.autoPinEdge(.right, to: .right, of: placeholderView)
                    questionView1.autoConstrainAttribute(.width, to: .width, of: questionView2)
                    questionView1.autoConstrainAttribute(.height, to: .height, of: questionView2)
                    questionView1.autoAlignAxis(.horizontal, toSameAxisOf: questionView2)
                    questionView1.autoPinEdge(.left, to: .right, of: questionView2, withOffset: 50)
                } as NSArray
            v12_Constraints =
                NSLayoutConstraint.autoCreateConstraintsWithoutInstalling {
                    questionView2.autoPinEdge(.top, to: .top, of: placeholderView)
                    questionView2.autoPinEdge(.bottom, to: .bottom, of: placeholderView)
                    questionView2.autoPinEdge(.left, to: .left, of: placeholderView)
                    questionView2.autoPinEdge(.right, to: .right, of: placeholderView)
                    questionView1.autoConstrainAttribute(.width, to: .width, of: questionView2)
                    questionView1.autoConstrainAttribute(.height, to: .height, of: questionView2)
                    questionView1.autoAlignAxis(.horizontal, toSameAxisOf: questionView2)
                    questionView2.autoPinEdge(.left, to: .right, of: questionView1, withOffset: 50)
                } as NSArray
            v21_Constraints =
                NSLayoutConstraint.autoCreateConstraintsWithoutInstalling {
                    questionView1.autoPinEdge(.top, to: .top, of: placeholderView)
                    questionView1.autoPinEdge(.bottom, to: .bottom, of: placeholderView)
                    questionView1.autoPinEdge(.left, to: .left, of: placeholderView)
                    questionView1.autoPinEdge(.right, to: .right, of: placeholderView)
                    questionView2.autoConstrainAttribute(.width, to: .width, of: questionView1)
                    questionView2.autoConstrainAttribute(.height, to: .height, of: questionView1)
                    questionView2.autoAlignAxis(.horizontal, toSameAxisOf: questionView1)
                    questionView1.autoPinEdge(.left, to: .right, of: questionView2, withOffset: 50)
                } as NSArray
            vOffConstraints =
                NSLayoutConstraint.autoCreateConstraintsWithoutInstalling {
                    questionView1.autoConstrainAttribute(.width, to: .width, of: placeholderView)
                    questionView1.autoConstrainAttribute(.height, to: .height, of: placeholderView)
                    questionView1.autoAlignAxis(.horizontal, toSameAxisOf: placeholderView)
                    placeholderView.autoPinEdge(.left, to: .right, of: questionView1, withOffset: 50)
                    questionView2.autoConstrainAttribute(.width, to: .width, of: placeholderView)
                    questionView2.autoConstrainAttribute(.height, to: .height, of: placeholderView)
                    questionView2.autoAlignAxis(.horizontal, toSameAxisOf: placeholderView)
                    placeholderView.autoPinEdge(.left, to: .right, of: questionView2, withOffset: 50)
                } as NSArray
            didSetupConstraints = true
        }
        super.updateViewConstraints()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier != nil {
            if segue.identifier! == SegueIdentifiers.QuizQuestion1SegueIdentifier {
                questionVc1 = segue.destination as? QuizQuestionViewController
                questionVc1!.quizQuestionDelegate = self
                if viewMode == .Question1 && quizSession != nil {
                    questionVc1!.quizQuestion = quizSession!.currentQuestion
                }
            }
            else {
                questionVc2 = segue.destination as? QuizQuestionViewController
                questionVc2!.quizQuestionDelegate = self
                if viewMode == .Question2 && quizSession != nil {
                    questionVc2!.quizQuestion = quizSession!.currentQuestion
                }
            }
        }
        else {
            super.prepare(for: segue, sender: sender)
        }
    }
    
    // MARK: - Actions
    @IBAction func handleContinueTap(_ sender: UIButton) {
        let transition = quizSession!.continueTapped()
        switch transition {
        case .NoTransition:
            updateState()
        case .Transition:
            viewMode = (viewMode == .Question1) ? .Question2 : .Question1
            updateState()
            if viewMode == .Question2 {
                questionVc2?.quizQuestion = quizSession!.currentQuestion
                questionView2.isHidden = false
                UIView.animate(withDuration: 0.5, animations: {
                    self.v_12Constraints!.autoRemoveConstraints()
                    self.v12_Constraints!.autoInstallConstraints()
                    self.view.layoutIfNeeded()
                }, completion: { (finished) in
                    self.questionView1.isHidden = true
                    self.v12_Constraints!.autoRemoveConstraints()
                    self.v_21Constraints!.autoInstallConstraints()
                    self.view.layoutIfNeeded()
                })
            }
            else {
                questionVc1?.quizQuestion = quizSession!.currentQuestion
                questionView1.isHidden = false
                UIView.animate(withDuration: 0.5, animations: {
                    self.v_21Constraints!.autoRemoveConstraints()
                    self.v21_Constraints!.autoInstallConstraints()
                    self.view.layoutIfNeeded()
                }, completion: { (finished) in
                    self.questionView2.isHidden = true
                    self.v21_Constraints!.autoRemoveConstraints()
                    self.v_12Constraints!.autoInstallConstraints()
                    self.view.layoutIfNeeded()
                })
            }
        default:
            if viewMode == .Question1 {
                UIView.animate(withDuration: 0.5, animations: {
                    self.v_12Constraints!.autoRemoveConstraints()
                    self.vOffConstraints!.autoInstallConstraints()
                    self.view.layoutIfNeeded()
                }, completion: { (finished) in
                    self.questionView1.isHidden = true
                    self.setupResults()
                })
            }
            else {
                UIView.animate(withDuration: 0.5, animations: {
                    self.v_21Constraints!.autoRemoveConstraints()
                    self.vOffConstraints!.autoInstallConstraints()
                    self.view.layoutIfNeeded()
                }, completion: { (finished) in
                    self.questionView2.isHidden = true
                    self.setupResults()
                })
            }
            viewMode = .Results
        }
    }
}
