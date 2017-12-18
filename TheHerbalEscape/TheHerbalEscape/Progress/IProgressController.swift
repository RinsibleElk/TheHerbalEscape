//
//  IProgressController.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 14/12/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import Foundation

/// Protocol for tracking progress.
protocol IProgressController {
    /// Create a new flashcard session for a given course.
    func createFlashcardSession(course:String?, contentRepository: IContentRepository) -> IFlashcardSession

    /// Fetch a sample of progress values.
    func fetchProgress(course: String?) -> [Progress]
    
    /// Fetch progress given a key.
    func fetchProgress(progressKey: ProgressKey) -> Progress?
    
    /// Load initial data for all progress.
    func loadInitialData(contentRepository: IContentRepository)
    
    /// Save after changing.
    func save() throws
}