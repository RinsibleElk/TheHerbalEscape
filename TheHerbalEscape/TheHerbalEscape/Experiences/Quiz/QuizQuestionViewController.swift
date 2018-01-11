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
    @IBOutlet weak var answer1ImageView: UIImageView!
    @IBOutlet weak var answer2ImageView: UIImageView!
    @IBOutlet weak var answer3ImageView: UIImageView!
    @IBOutlet weak var answer4ImageView: UIImageView!
    var quizQuestion: QuizQuestion? {
        didSet {
            if quizQuestion != nil {
                questionTextLabel.text = quizQuestion!.Question
                imagesDefined = quizQuestion!.Answers[0].ImageName != nil
                answer1TextLabel.text = quizQuestion!.Answers[0].Answer
                answer2TextLabel.text = quizQuestion!.Answers[1].Answer
                answer3TextLabel.text = quizQuestion!.Answers[2].Answer
                answer4TextLabel.text = quizQuestion!.Answers[3].Answer
                answer1ImageView.image = quizQuestion!.Answers[0].ImageName == nil ? nil : (UIImage(named: quizQuestion!.Answers[0].ImageName!) ?? #imageLiteral(resourceName: "noImage"))
                answer2ImageView.image = quizQuestion!.Answers[1].ImageName == nil ? nil : (UIImage(named: quizQuestion!.Answers[1].ImageName!) ?? #imageLiteral(resourceName: "noImage"))
                answer3ImageView.image = quizQuestion!.Answers[2].ImageName == nil ? nil : (UIImage(named: quizQuestion!.Answers[2].ImageName!) ?? #imageLiteral(resourceName: "noImage"))
                answer4ImageView.image = quizQuestion!.Answers[3].ImageName == nil ? nil : (UIImage(named: quizQuestion!.Answers[3].ImageName!) ?? #imageLiteral(resourceName: "noImage"))
                setupCurvedView(view: questionView, answerState: .Normal, isQuestion: true)
                setupViewConstraints()
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
    private var twoByTwoWithImagesConstraints: NSArray?
    private var tapGesture1: UITapGestureRecognizer?
    private var tapGesture2: UITapGestureRecognizer?
    private var tapGesture3: UITapGestureRecognizer?
    private var tapGesture4: UITapGestureRecognizer?
    private var imagesIncluded: Bool = false
    private var imagesDefined: Bool = false

    // MARK: - Private functions
    private func setupCurvedView(view: UIView, answerState: QuizAnswerState, isQuestion: Bool) {
        view.layer.borderWidth = answerState.getBorderThickness()
        view.layer.borderColor = answerState.getBorderColor()
        view.layer.cornerRadius = 30
        view.layer.masksToBounds = true
        view.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMaxXMinYCorner,.layerMinXMaxYCorner,.layerMinXMinYCorner]
        view.backgroundColor = (isQuestion && quizQuestion != nil) ? quizQuestion!.Color.getUiColor() : answerState.getBackgroundColor()
    }
    
    private func setupViewConstraints() {
        if (!imagesDefined || traitCollection.verticalSizeClass != .regular) && imagesIncluded {
            twoByTwoWithImagesConstraints?.autoRemoveConstraints()
            twoByTwoConstraints?.autoInstallConstraints()
            answer1ImageView.isHidden = true
            answer2ImageView.isHidden = true
            answer3ImageView.isHidden = true
            answer4ImageView.isHidden = true
            imagesIncluded = false
            self.view.layoutIfNeeded()
        }
        else if imagesDefined && !imagesIncluded && traitCollection.verticalSizeClass == .regular {
            twoByTwoConstraints?.autoRemoveConstraints()
            twoByTwoWithImagesConstraints?.autoInstallConstraints()
            answer1ImageView.isHidden = false
            answer2ImageView.isHidden = false
            answer3ImageView.isHidden = false
            answer4ImageView.isHidden = false
            imagesIncluded = true
            self.view.layoutIfNeeded()
        }
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
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setupViewConstraints()
    }

    override func updateViewConstraints() {
        if (!didSetupConstraints) {
            twoByTwoConstraints =
                NSLayoutConstraint.autoCreateConstraintsWithoutInstalling {
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
            twoByTwoWithImagesConstraints =
                NSLayoutConstraint.autoCreateConstraintsWithoutInstalling {
                    questionView.autoPinEdge(toSuperviewEdge: .top)
                    questionView.autoPinEdge(toSuperviewEdge: .left)
                    questionView.autoPinEdge(toSuperviewEdge: .right)
                    questionView.autoConstrainAttribute(.height, to: .height, of: placeholderView, withMultiplier: 0.2)
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
                    answer1ImageView.autoPinEdge(toSuperviewEdge: .left, withInset: 8)
                    answer1ImageView.autoPinEdge(toSuperviewEdge: .right, withInset: 8)
                    answer1ImageView.autoPinEdge(toSuperviewEdge: .top, withInset: 16)
                    answer1TextLabel.autoPinEdge(.top, to: .bottom, of: answer1ImageView, withOffset: 8)
                    answer1TextLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: 8)
                    answer1ImageView.autoConstrainAttribute(.height, to: .height, of: answer1View, withMultiplier: 0.6)
                    answer2TextLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 8)
                    answer2TextLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 8)
                    answer2ImageView.autoPinEdge(toSuperviewEdge: .left, withInset: 8)
                    answer2ImageView.autoPinEdge(toSuperviewEdge: .right, withInset: 8)
                    answer2ImageView.autoPinEdge(toSuperviewEdge: .top, withInset: 16)
                    answer2TextLabel.autoPinEdge(.top, to: .bottom, of: answer2ImageView, withOffset: 8)
                    answer2TextLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: 8)
                    answer2ImageView.autoConstrainAttribute(.height, to: .height, of: answer2View, withMultiplier: 0.6)
                    answer3TextLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 8)
                    answer3TextLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 8)
                    answer3ImageView.autoPinEdge(toSuperviewEdge: .left, withInset: 8)
                    answer3ImageView.autoPinEdge(toSuperviewEdge: .right, withInset: 8)
                    answer3ImageView.autoPinEdge(toSuperviewEdge: .top, withInset: 16)
                    answer3TextLabel.autoPinEdge(.top, to: .bottom, of: answer3ImageView, withOffset: 8)
                    answer3TextLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: 8)
                    answer3ImageView.autoConstrainAttribute(.height, to: .height, of: answer3View, withMultiplier: 0.6)
                    answer4TextLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 8)
                    answer4TextLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 8)
                    answer4ImageView.autoPinEdge(toSuperviewEdge: .left, withInset: 8)
                    answer4ImageView.autoPinEdge(toSuperviewEdge: .right, withInset: 8)
                    answer4ImageView.autoPinEdge(toSuperviewEdge: .top, withInset: 16)
                    answer4TextLabel.autoPinEdge(.top, to: .bottom, of: answer4ImageView, withOffset: 8)
                    answer4TextLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: 8)
                    answer4ImageView.autoConstrainAttribute(.height, to: .height, of: answer4View, withMultiplier: 0.6)
                } as NSArray
            if !imagesDefined || traitCollection.verticalSizeClass != .regular {
                twoByTwoConstraints?.autoInstallConstraints()
                answer1ImageView.isHidden = true
                answer2ImageView.isHidden = true
                answer3ImageView.isHidden = true
                answer4ImageView.isHidden = true
                imagesIncluded = false
            }
            else {
                twoByTwoWithImagesConstraints?.autoInstallConstraints()
                answer1ImageView.isHidden = false
                answer2ImageView.isHidden = false
                answer3ImageView.isHidden = false
                answer4ImageView.isHidden = false
                imagesIncluded = true
            }
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
