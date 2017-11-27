//
//  FlashcardProgress.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 27/11/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import Foundation

// managedObjectContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
// add a uniqueness constraint on FlashcardName in FlashcardProgress, then inserting a new model will
// just overwrite the last
public class FlashcardProgressModel: IFlashcardProgressModel {
    // MARK: - Private properties
    private var flashcardProgress : FlashcardProgress

    // MARK: - Initializers
    /// Construct out of a real flashcard progress.
    init(flashcardProgress: FlashcardProgress) {
        self.flashcardProgress = flashcardProgress
    }
}
