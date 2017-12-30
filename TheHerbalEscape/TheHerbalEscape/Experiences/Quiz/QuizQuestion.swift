//
//  QuizQuestion.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 30/12/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import UIKit

/// Quiz question and answers, as presented to the user.
class QuizQuestion: Codable {
    // MARK: - Properties
    
    /// The colour to show for the question.
    var Color: CourseColor
    
    /// The question.
    var Question: String

    /// Whether this supports multiple selection.
    var SupportsMultipleSelection: Bool
    
    /// The answers.
    var Answers: [QuizAnswer]
    
    // MARK: - Initializers
    init(color: CourseColor, question: String, supportsMultipleSelection: Bool, answers: [QuizAnswer]) {
        Color = color
        Question = question
        SupportsMultipleSelection = supportsMultipleSelection
        Answers = answers
    }
}

