//
//  UInt16Extensions.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 31/12/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import Foundation

extension Int16 {
    func toDifficulty() -> FlashcardDifficulty {
        switch self {
        case 0:
            return .veryHard
        case 1:
            return .hard
        case 2:
            return .easy
        default:
            return .veryEasy
        }
    }
}
