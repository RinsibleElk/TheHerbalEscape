//
//  ProgressSummary.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 31/12/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import Foundation

/// Summary for progress for a given course or overall.
class ProgressSummary: Codable {
    /// The optional course.
    var Course: String?
    
    /// The number of very easies.
    var VeryEasyCount: Int = 0
    
    /// The number of easies.
    var EasyCount: Int = 0
    
    /// The number of hards.
    var HardCount: Int = 0
    
    /// The number of very hards.
    var VeryHardCount: Int = 0
    
    /// Percentage.
    var Percentage: Float {
        get {
            let total = VeryEasyCount + EasyCount + HardCount + VeryHardCount
            let totalEasy = VeryEasyCount + EasyCount
            if total == 0 {
                return 100.0
            }
            else {
                return 100.0 * (Float(totalEasy) / Float(total))
            }
        }
    }
    
    // MARK: - Initializers
    init(course: String?) {
        Course = course
    }
    
    // MARK: - API
    /// Update the difficulty of a flashcard or question.
    func update(oldValue: FlashcardDifficulty?, newValue: FlashcardDifficulty) {
        if (oldValue != nil) {
            switch oldValue! {
            case .easy:
                EasyCount = EasyCount - 1
            case .veryEasy:
                VeryEasyCount = VeryEasyCount - 1
            case .hard:
                HardCount = HardCount - 1
            case .veryHard:
                VeryHardCount = VeryHardCount - 1
            }
        }
        switch newValue {
        case .easy:
            EasyCount = EasyCount + 1
        case .veryEasy:
            VeryEasyCount = VeryEasyCount + 1
        case .hard:
            HardCount = HardCount + 1
        case .veryHard:
            VeryHardCount = VeryHardCount + 1
        }
    }
}
