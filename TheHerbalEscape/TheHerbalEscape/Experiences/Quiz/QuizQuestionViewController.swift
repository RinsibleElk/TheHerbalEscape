//
//  QuizQuestionViewController.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 07/01/2018.
//  Copyright © 2018 Oliver Samson. All rights reserved.
//

import UIKit
import PureLayout

class QuizQuestionViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet weak var placeholderView: UIView!
    @IBOutlet weak var questionView: UIView!
    @IBOutlet weak var answerSectionView: UIView!
    @IBOutlet weak var answer1View: UIView!
    @IBOutlet weak var answer2View: UIView!
    @IBOutlet weak var answer3View: UIView!
    @IBOutlet weak var answer4View: UIView!
    weak var quizQuestionDelegate: IQuizQuestionDelegate!
    @IBOutlet weak var questionTextLabel: UILabel!
    @IBOutlet weak var answer1TextLabel: UILabel!
    @IBOutlet weak var answer2TextLabel: UILabel!
    @IBOutlet weak var answer3TextLabel: UILabel!
    @IBOutlet weak var answer4TextLabel: UILabel!
    var quizQuestion: QuizQuestion? {
        didSet {
            if quizQuestion != nil {
                questionTextLabel.text = quizQuestion!.Question
                answer1TextLabel.text = quizQuestion!.Answers[0].Answer
                answer2TextLabel.text = quizQuestion!.Answers[1].Answer
                answer3TextLabel.text = quizQuestion!.Answers[2].Answer
                answer4TextLabel.text = quizQuestion!.Answers[3].Answer
                setupCurvedView(view: questionView, answerState: .Normal, isQuestion: true)
            }
        }
    }
    
    // MARK: - Private properties
    private var answer1State: QuizAnswerState = .Normal
    private var answer2State: QuizAnswerState = .Normal
    private var answer3State: QuizAnswerState = .Normal
    private var answer4State: QuizAnswerState = .Normal
    private var didSetupConstraints: Bool = false
    private var twoByTwoConstraints: NSArray?
    private var fourByOneConstraints: NSArray?
    private var oneByFourConstraints: NSArray?
    private var tapGesture1: UITapGestureRecognizer?
    private var tapGesture2: UITapGestureRecognizer?
    private var tapGesture3: UITapGestureRecognizer?
    private var tapGesture4: UITapGestureRecognizer?

    // MARK: - Private functions
    private func setupCurvedView(view: UIView, answerState: QuizAnswerState, isQuestion: Bool) {
        view.layer.borderWidth = answerState.getBorderThickness()
        view.layer.borderColor = answerState.getBorderColor()
        view.layer.cornerRadius = 30
        view.layer.masksToBounds = true
        view.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMaxXMinYCorner,.layerMinXMaxYCorner,.layerMinXMinYCorner]
        view.backgroundColor = (isQuestion && quizQuestion != nil) ? quizQuestion!.Color.getUiColor() : answerState.getBackgroundColor()
    }
    
    // MARK: - API
    func setAnswerState(answerIndex: Int, answerState: QuizAnswerState) {
        switch answerIndex {
        case 1:
            if answer1State != answerState {
                answer1State = answerState
                setupCurvedView(view: answer1View, answerState: answerState, isQuestion: false)
            }
        case 2:
            if answer2State != answerState {
                answer2State = answerState
                setupCurvedView(view: answer2View, answerState: answerState, isQuestion: false)
            }
        case 3:
            if answer3State != answerState {
                answer3State = answerState
                setupCurvedView(view: answer3View, answerState: answerState, isQuestion: false)
            }
        default:
            if answer4State != answerState {
                answer4State = answerState
                setupCurvedView(view: answer4View, answerState: answerState, isQuestion: false)
            }
        }
    }
    
    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupCurvedView(view: questionView, answerState: .Normal, isQuestion: true)
        setupCurvedView(view: answer1View, answerState: answer1State, isQuestion: false)
        setupCurvedView(view: answer2View, answerState: answer2State, isQuestion: false)
        setupCurvedView(view: answer3View, answerState: answer3State, isQuestion: false)
        setupCurvedView(view: answer4View, answerState: answer4State, isQuestion: false)

        // Gesture recognisers
        tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(QuizQuestionViewController.handleTap1(_:)))
        answer1View.addGestureRecognizer(tapGesture1!)
        tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(QuizQuestionViewController.handleTap2(_:)))
        answer2View.addGestureRecognizer(tapGesture2!)
        tapGesture3 = UITapGestureRecognizer(target: self, action: #selector(QuizQuestionViewController.handleTap3(_:)))
        answer3View.addGestureRecognizer(tapGesture3!)
        tapGesture4 = UITapGestureRecognizer(target: self, action: #selector(QuizQuestionViewController.handleTap4(_:)))
        answer4View.addGestureRecognizer(tapGesture4!)
    }
    
    @objc func handleTap1(_ sender:UITapGestureRecognizer) {
        quizQuestionDelegate.tapped(answerIndex: 1)
    }
    
    @objc func handleTap2(_ sender:UITapGestureRecognizer) {
        quizQuestionDelegate.tapped(answerIndex: 2)
    }
    
    @objc func handleTap3(_ sender:UITapGestureRecognizer) {
        quizQuestionDelegate.tapped(answerIndex: 3)
    }
    
    @objc func handleTap4(_ sender:UITapGestureRecognizer) {
        quizQuestionDelegate.tapped(answerIndex: 4)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func updateViewConstraints() {
        if (!didSetupConstraints) {
            twoByTwoConstraints =
                NSLayoutConstraint.autoCreateAndInstallConstraints {
                    questionView.autoPinEdge(toSuperviewEdge: .top)
                    questionView.autoPinEdge(toSuperviewEdge: .left)
                    questionView.autoPinEdge(toSuperviewEdge: .right)
                    questionView.autoConstrainAttribute(.height, to: .height, of: placeholderView, withMultiplier: 0.5)
                    answerSectionView.autoPinEdge(.top, to: .bottom, of: questionView, withOffset: 8)
                    answerSectionView.autoPinEdge(toSuperviewEdge: .left)
                    answerSectionView.autoPinEdge(toSuperviewEdge: .right)
                    answerSectionView.autoPinEdge(toSuperviewEdge: .bottom)
                    answer1View.autoConstrainAttribute(.width, to: .width, of: answer2View)
                    answer2View.autoConstrainAttribute(.width, to: .width, of: answer3View)
                    answer3View.autoConstrainAttribute(.width, to: .width, of: answer4View)
                    answer1View.autoConstrainAttribute(.height, to: .height, of: answer2View)
                    answer2View.autoConstrainAttribute(.height, to: .height, of: answer3View)
                    answer3View.autoConstrainAttribute(.height, to: .height, of: answer4View)
                    answer1View.autoPinEdge(toSuperviewEdge: .left)
                    answer3View.autoPinEdge(toSuperviewEdge: .left)
                    answer2View.autoPinEdge(toSuperviewEdge: .right)
                    answer4View.autoPinEdge(toSuperviewEdge: .right)
                    answer1View.autoPinEdge(toSuperviewEdge: .top)
                    answer2View.autoPinEdge(toSuperviewEdge: .top)
                    answer2View.autoPinEdge(.left, to: .right, of: answer1View, withOffset: 8)
                    answer3View.autoPinEdge(toSuperviewEdge: .bottom)
                    answer4View.autoPinEdge(toSuperviewEdge: .bottom)
                    answer4View.autoPinEdge(.left, to: .right, of: answer3View, withOffset: 8)
                    answer3View.autoPinEdge(.top, to: .bottom, of: answer1View, withOffset: 8)
                    answer4View.autoPinEdge(.top, to: .bottom, of: answer2View, withOffset: 8)
                    questionTextLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 8)
                    questionTextLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 8)
                    questionTextLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 8)
                    questionTextLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: 8)
                    answer1TextLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 8)
                    answer1TextLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 8)
                    answer1TextLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 8)
                    answer1TextLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: 8)
                    answer2TextLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 8)
                    answer2TextLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 8)
                    answer2TextLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 8)
                    answer2TextLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: 8)
                    answer3TextLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 8)
                    answer3TextLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 8)
                    answer3TextLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 8)
                    answer3TextLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: 8)
                    answer4TextLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 8)
                    answer4TextLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 8)
                    answer4TextLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 8)
                    answer4TextLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: 8)
                } as NSArray
            fourByOneConstraints =
                NSLayoutConstraint.autoCreateConstraintsWithoutInstalling {
                    questionView.autoPinEdge(toSuperviewEdge: .top)
                    questionView.autoPinEdge(toSuperviewEdge: .left)
                    questionView.autoPinEdge(toSuperviewEdge: .right)
                    questionView.autoConstrainAttribute(.height, to: .height, of: placeholderView, withMultiplier: 0.5)
                    answer1View.autoConstrainAttribute(.width, to: .width, of: answer2View)
                    answer2View.autoConstrainAttribute(.width, to: .width, of: answer3View)
                    answer3View.autoConstrainAttribute(.width, to: .width, of: answer4View)
                    answer1View.autoConstrainAttribute(.height, to: .height, of: answer2View)
                    answer2View.autoConstrainAttribute(.height, to: .height, of: answer3View)
                    answer3View.autoConstrainAttribute(.height, to: .height, of: answer4View)
                    answer1View.autoPinEdge(toSuperviewEdge: .left)
                    answer3View.autoPinEdge(toSuperviewEdge: .left)
                    answer2View.autoPinEdge(toSuperviewEdge: .right)
                    answer4View.autoPinEdge(toSuperviewEdge: .right)
                    answer1View.autoPinEdge(.top, to: .bottom, of: questionView, withOffset: 8)
                    answer2View.autoPinEdge(.top, to: .bottom, of: questionView, withOffset: 8)
                    answer1View.autoPinEdge(.right, to: .left, of: answer2View, withOffset: 8)
                    answer3View.autoPinEdge(toSuperviewEdge: .bottom)
                    answer4View.autoPinEdge(toSuperviewEdge: .bottom)
                    answer3View.autoPinEdge(.right, to: .left, of: answer4View, withOffset: 8)
                    answer3View.autoPinEdge(.top, to: .bottom, of: answer1View, withOffset: 8)
                    answer4View.autoPinEdge(.top, to: .bottom, of: answer2View, withOffset: 8)
                } as NSArray
            oneByFourConstraints =
                NSLayoutConstraint.autoCreateConstraintsWithoutInstalling {
                    questionView.autoPinEdge(toSuperviewEdge: .top)
                    questionView.autoPinEdge(toSuperviewEdge: .left)
                    questionView.autoPinEdge(toSuperviewEdge: .right)
                    questionView.autoConstrainAttribute(.height, to: .height, of: placeholderView, withMultiplier: 0.5)
                    answer1View.autoConstrainAttribute(.width, to: .width, of: answer2View)
                    answer2View.autoConstrainAttribute(.width, to: .width, of: answer3View)
                    answer3View.autoConstrainAttribute(.width, to: .width, of: answer4View)
                    answer1View.autoConstrainAttribute(.height, to: .height, of: answer2View)
                    answer2View.autoConstrainAttribute(.height, to: .height, of: answer3View)
                    answer3View.autoConstrainAttribute(.height, to: .height, of: answer4View)
                    answer1View.autoPinEdge(toSuperviewEdge: .left)
                    answer3View.autoPinEdge(toSuperviewEdge: .left)
                    answer2View.autoPinEdge(toSuperviewEdge: .right)
                    answer4View.autoPinEdge(toSuperviewEdge: .right)
                    answer1View.autoPinEdge(.top, to: .bottom, of: questionView, withOffset: 8)
                    answer2View.autoPinEdge(.top, to: .bottom, of: questionView, withOffset: 8)
                    answer1View.autoPinEdge(.right, to: .left, of: answer2View, withOffset: 8)
                    answer3View.autoPinEdge(toSuperviewEdge: .bottom)
                    answer4View.autoPinEdge(toSuperviewEdge: .bottom)
                    answer3View.autoPinEdge(.right, to: .left, of: answer4View, withOffset: 8)
                    answer3View.autoPinEdge(.top, to: .bottom, of: answer1View, withOffset: 8)
                    answer4View.autoPinEdge(.top, to: .bottom, of: answer2View, withOffset: 8)
                } as NSArray
            didSetupConstraints = true
        }
        super.updateViewConstraints()
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
