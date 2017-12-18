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
    /// Returns the previous difficulty, so that the UI can animate the transition back.
    func undo() -> FlashcardDifficulty
    
    /// Move to the next card (if there is one) and mark the current card with the difficulty given.
    func finishCard(difficulty: FlashcardDifficulty)
    
    /// Current card front side.
    var currentFrontSide: FlashcardSide { get }
    
    /// Current card back side.
    var currentBackSide: FlashcardSide { get }
    
    /// How many very easies for this session.
    var veryEasyCount: Int { get }
    
    /// How many easies for this session.
    var easyCount: Int { get }
    
    /// How many very hards for this session.
    var veryHardCount: Int { get }
    
    /// How many hards for this session.
    var hardCount: Int { get }
    
    /// Has the progress already been saved?
    var progressSaved: Bool { get }
    
    /// Save progress.
    func save(progressController: IProgressController)
}
