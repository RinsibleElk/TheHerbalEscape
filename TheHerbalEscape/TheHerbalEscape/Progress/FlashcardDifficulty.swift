//
//  FlashcardDifficulty.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 27/11/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import Foundation

/// Four levels of difficulty.
public enum FlashcardDifficulty : Int, Codable {
    case veryEasy
    case easy
    case hard
    case veryHard
    
    /// This is the reverse from the point of view of the UI, so probably doesn't belong here.
    func reverse() -> FlashcardDifficulty {
        switch self {
        case .veryEasy:
            return .hard
        case .easy:
            return .veryHard
        case .hard:
            return .veryEasy
        case .veryHard:
            return .easy
        }
    }
}
