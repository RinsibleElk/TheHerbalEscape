//
//  QuizAnswer.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 30/12/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import UIKit

/// Answer to a quiz question and whether it's correct or not.
class QuizAnswer: Codable {
    // MARK: - Properties

    /// The answer text.
    var Answer: String
    
    /// Whether it's correct.
    var IsCorrect: Bool
    
    // MARK: - Initializers
    init(answer: String, isCorrect: Bool) {
        Answer = answer
        IsCorrect = isCorrect
    }
}
