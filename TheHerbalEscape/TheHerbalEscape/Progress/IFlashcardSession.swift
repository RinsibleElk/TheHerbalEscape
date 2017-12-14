//
//  IFlashcardProgress.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 27/11/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import Foundation

/// Protocol defining how to interact with flashcard progress.
protocol IFlashcardSession : class, Codable {
    /// Whether there is anything to show.
    var hasMoreFlashcardsToShow: Bool { get }

    /// Is there anything to undo?
    var canUndo: Bool { get }
    
    /// Perform undo. Only valid if canUndo returns true.
    func undo()
    
    /// Move to the next card (if there is one) and mark the current card with the difficulty given.
    func finishCard(difficulty: FlashcardDifficulty)
    
    /// Current card front side.
    var currentFrontSide: FlashcardSide { get }
    
    /// Current card back side.
    var currentBackSide: FlashcardSide { get }
}
