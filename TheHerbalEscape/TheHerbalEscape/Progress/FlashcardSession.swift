//
//  FlashcardSession.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 14/12/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import Foundation
import GameKit

/// Represents the current flashcard session.
class FlashcardSession: IFlashcardSession {
    // MARK: - Properties
    var flashcards: [Flashcard]
    var currentIndex: Int = 0
    
    // MARK: - IFlashcardSession
    var veryEasyCount: Int = 0
    
    var easyCount: Int = 0
    
    var veryHardCount: Int = 0
    
    var hardCount: Int = 0
    
    var hasMoreFlashcardsToShow: Bool {
        get {
            return currentIndex < flashcards.count
        }
    }
    
    var canUndo: Bool {
        get {
            return currentIndex > 0
        }
    }
    
    func undo() -> FlashcardDifficulty {
        currentIndex = currentIndex - 1
        let difficulty = flashcards[currentIndex].Result!
        switch difficulty {
        case .easy:
            easyCount = easyCount - 1
        case .veryEasy:
            veryEasyCount = veryEasyCount - 1
        case .hard:
            hardCount = hardCount - 1
        case .veryHard:
            veryHardCount = veryHardCount - 1
        }
        flashcards[currentIndex].Result = nil
        return difficulty
    }
    
    func finishCard(difficulty: FlashcardDifficulty) {
        flashcards[currentIndex].Result = difficulty
        currentIndex = currentIndex + 1
        switch difficulty {
        case .easy:
            easyCount = easyCount + 1
        case .veryEasy:
            veryEasyCount = veryEasyCount + 1
        case .hard:
            hardCount = hardCount + 1
        case .veryHard:
            veryHardCount = veryHardCount + 1
        }
    }
    
    var currentFrontSide: FlashcardSide {
        get {
            return flashcards[currentIndex].Front
        }
    }
    
    var currentBackSide: FlashcardSide {
        get {
            return flashcards[currentIndex].Back
        }
    }
    
    var progressSaved: Bool = false
    
    func save(progressController: IProgressController) {
        progressSaved = true
        let date = Date()
        for flashcard in flashcards {
            if let progress = progressController.fetchProgress(progressKey: flashcard) {
                if let difficulty = flashcard.Result {
                    switch difficulty {
                    case .easy:
                        var timeInterval = DateComponents()
                        timeInterval.day = ProgressDateIntervals.easyDays
                        progress.dueDate = Calendar.current.date(byAdding: timeInterval, to: date)
                        progress.easyCount = 0
                    case .veryEasy:
                        var timeInterval = DateComponents()
                        timeInterval.day = ProgressDateIntervals.veryEasyDays
                        progress.dueDate = Calendar.current.date(byAdding: timeInterval, to: date)
                        progress.easyCount = progress.easyCount + 1
                    case .hard:
                        var timeInterval = DateComponents()
                        timeInterval.day = ProgressDateIntervals.hardDays
                        progress.dueDate = Calendar.current.date(byAdding: timeInterval, to: date)
                        progress.easyCount = 0
                    case .veryHard:
                        var timeInterval = DateComponents()
                        timeInterval.day = ProgressDateIntervals.veryHardDays
                        progress.dueDate = Calendar.current.date(byAdding: timeInterval, to: date)
                        progress.easyCount = 0
                    }
                }
            }
        }
        do {
            try progressController.save()
        }
        catch {
            return
        }
    }
    
    // MARK: - Initializers
    init(randomSeed: UInt64?, course: String?, progressController: IProgressController, contentRepository:IContentRepository) {
        let randomSource = GKMersenneTwisterRandomSource()
        if (randomSeed != nil) {
            randomSource.seed = randomSeed!
        }
        
        // Get some due progress objects.
        let progress = progressController.fetchProgress(course: course)
        var showCount = 10

        // Split the progress objects by whether they are actually due or not.
        var dueProgress = [Progress]()
        var notDueProgress = [Progress]()
        let date = Date()
        for progressObject in progress {
            if progressObject.dueDate! <= date {
                dueProgress.append(progressObject)
            }
            else {
                notDueProgress.append(progressObject)
            }
        }
        
        // Randomly insert due flashcards into the pile.
        flashcards = [Flashcard]()
        while (showCount > 0 && dueProgress.count > 0) {
            let index = randomSource.nextInt(upperBound: dueProgress.count)
            let progressObject = dueProgress.remove(at: index)
            
            // Get the question.
            let question = contentRepository.fetchQuestion(question: progressObject.question!)
            
            // Randomise the side to show.
            let reverseSide = question.ReverseFlashcardQuestion != nil && randomSource.nextBool()
            
            // Add the flashcard.
            flashcards.append(Flashcard(contentRepository: contentRepository, reverseSide: reverseSide, question: question, name: progressObject.name!))
            showCount = showCount - 1
        }
        
        // Insert any remaining flashcards into the pile. Do this in order, because there aren't sufficient due flashcards to show?
        while (showCount > 0 && notDueProgress.count > 0) {
            let progressObject = notDueProgress.removeFirst()
            
            // Get the question.
            let question = contentRepository.fetchQuestion(question: progressObject.question!)
            
            // Randomise the side to show.
            let reverseSide = question.ReverseFlashcardQuestion != nil && randomSource.nextBool()
            
            // Add the flashcard.
            flashcards.append(Flashcard(contentRepository: contentRepository, reverseSide: reverseSide, question: question, name: progressObject.name!))
            showCount = showCount - 1
        }
    }
}
