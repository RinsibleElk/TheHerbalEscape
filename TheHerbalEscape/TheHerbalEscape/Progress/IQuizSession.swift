//
//  IQuizSession.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 30/12/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import Foundation

enum QuizTransition {
    case NoTransition
    case Transition
    case Results
}

/// Protocol for defining how to interact with quiz progress.
protocol IQuizSession: Codable {
    /// Whether there is anything to show.
    var hasMoreQuestionsToShow: Bool { get }

    /// Current card front side.
    var currentQuestion: QuizQuestion { get }
    
    /// Toggle whether an answer is selected.
    func toggleAnswer(answerIndex: Int)
    
    /// View the state for the answers.
    func getState(answerIndex: Int) -> QuizAnswerState
    
    /// When the user hits the continue button.
    func continueTapped() -> QuizTransition
    
    /// Whether the continue button should be enabled.
    var continueEnabled:Bool { get }

    /// Number of correct answers given.
    var numCorrect: Int { get }

    /// Number of incorrect answers given.
    var numIncorrect: Int { get }
    
    /// Whether the results have been saved.
    var haveSaved: Bool { get }
    
    /// Save results.
    func save(progressController: IProgressController)
}
