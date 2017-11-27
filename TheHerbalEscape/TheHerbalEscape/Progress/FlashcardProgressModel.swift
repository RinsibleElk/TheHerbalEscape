//
//  FlashcardProgress.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 27/11/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import Foundation

// add a uniqueness constraint on FlashcardName in FlashcardProgress, then inserting a new model will
// just overwrite the last
public class FlashcardProgressModel: IFlashcardProgressModel {
    // MARK: - IFlashcardProgressModel
    public var easyCount: Int16 {
        get {
            return flashcardProgress.easyCount
        }
        set {
            flashcardProgress.easyCount = newValue
        }
    }
    
    public var nextDate: Date {
        get {
            return flashcardProgress.nextDate!
        }
        set {
            flashcardProgress.nextDate = newValue
        }
    }
    
    public func resetToOriginalState() {
        easyCount = originalEasyCount
        nextDate = originalNextDate
    }
    
    // MARK: - Private properties
    private var flashcardProgress : FlashcardProgress
    private var originalNextDate : Date
    private var originalEasyCount : Int16

    // MARK: - Initializers
    /// Construct out of a real flashcard progress.
    init(flashcardProgress: FlashcardProgress) {
        self.flashcardProgress = flashcardProgress
        self.originalNextDate = flashcardProgress.nextDate!
        self.originalEasyCount = flashcardProgress.easyCount
    }
}
