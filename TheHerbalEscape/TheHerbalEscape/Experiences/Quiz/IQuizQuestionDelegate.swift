//
//  IQuizQuestionDelegate.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 07/01/2018.
//  Copyright © 2018 Oliver Samson. All rights reserved.
//

import Foundation

/// Performs selections and UI changes for a quiz question.
protocol IQuizQuestionDelegate: class {
    /// Called by the question vc when an answer is tapped.
    func tapped(answerIndex: Int)
}
