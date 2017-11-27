//
//  IDataController.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 27/11/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import Foundation

/// Container for all persisted data.
public protocol IDataController : class {
    /// Fetch all of the flashcard progress models.
    func fetchAllFlashcardProgress() -> [IFlashcardProgressModel]
    
    /// Create a new progress model for a flashcard name.
    func initNewFlashcardProgress(name: String) -> IFlashcardProgressModel

    /// Save all changes.
    func save()
}
