//
//  QuizAnswerState.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 07/01/2018.
//  Copyright © 2018 Oliver Samson. All rights reserved.
//

import UIKit

/// Answer states in the UI.
enum QuizAnswerState: Int, Codable {
    /// The default state - not selected.
    case Normal = 1
    /// The user has selected this answer but not submitted.
    case Selected = 2
    /// The answer has been revealed. The user selected the answer and was correct.
    case SelectedCorrect = 3
    /// The answer has been revealed. The user selected the answer and was incorrect.
    case SelectedIncorrect = 4
    /// The answer has been revealed. The user did not select the answer and was incorrect (ie the answer is right).
    case UnselectedIncorrect = 5
    
    /// Get the border thickness for the UI.
    func getBorderThickness() -> CGFloat {
        switch self {
        case .Normal:
            return 3
        default:
            return 5
        }
    }

    /// Get the border color for the UI.
    func getBorderColor() -> CGColor {
        switch self {
        case .Normal:
            return Colors.Black.cgColor
        case .Selected:
            return Colors.QuizOrangeBorder.cgColor
        case .SelectedIncorrect:
            return Colors.QuizRedBorder.cgColor
        default:
            return Colors.QuizGreenBorder.cgColor
        }
    }

    /// Get the background color for the UI.
    func getBackgroundColor() -> UIColor {
        switch self {
        case .SelectedCorrect:
            return Colors.QuizGreenBackground
        case .SelectedIncorrect:
            return Colors.QuizRedBackground
        case .UnselectedIncorrect:
            return Colors.QuizRedBackground
        default:
            return Colors.White
        }
    }
    
    /// Toggle the selection.
    func toggle() -> QuizAnswerState {
        switch self {
        case .Normal:
            return .Selected
        case .Selected:
            return .Normal
        default:
            return self
        }
    }
}
