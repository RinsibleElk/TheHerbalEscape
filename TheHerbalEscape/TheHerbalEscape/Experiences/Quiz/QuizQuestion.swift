//
//  QuizQuestion.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 30/12/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import UIKit

/// Quiz question and answers, as presented to the user.
class QuizQuestion: Codable, ProgressKey {
    // MARK: - ProgressKey
    var question: String {
        get {
            return QuestionName
        }
    }
    
    var name: String {
        get {
            return ContentName
        }
    }
    
    // MARK: - Properties
    
    /// The colour to show for the question.
    var Color: CourseColor
    
    /// The question name.
    var QuestionName: String
    
    /// The content name. This is the content that is intended to be under test.
    var ContentName: String
    
    /// The question text.
    var Question: String

    /// Whether this supports multiple selection.
    var SupportsMultipleSelection: Bool
    
    /// The answers.
    var Answers: [QuizAnswer]
    
    // MARK: - Initializers
    init(color: CourseColor, questionName: String, contentName: String, questionText: String, supportsMultipleSelection: Bool, answers: [QuizAnswer]) {
        Color = color
        QuestionName = questionName
        ContentName = contentName
        Question = questionText
        SupportsMultipleSelection = supportsMultipleSelection
        Answers = answers
    }
}

