//
//  ProgressFacade.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 06/01/2018.
//  Copyright © 2018 Oliver Samson. All rights reserved.
//

import Foundation

class ProgressFacade: IProgressFacade {
    // MARK: - IProgressFacade
    var dueDate: Date {
        get {
            return progress.dueDate!
        }
        set {
            progress.dueDate = newValue
        }
    }
    
    var easyCount: Int16 {
        get {
            return progress.easyCount
        }
        set {
            progress.easyCount = newValue
        }
    }
    
    var lastDifficulty: FlashcardDifficulty {
        get {
            return progress.lastDifficulty.toDifficulty()
        }
        set {
            progress.lastDifficulty = newValue.toInt16()
        }
    }
    
    var name: String {
        get {
            return progress.name!
        }
        set {
            progress.name = newValue
        }
    }
    
    var question: String {
        get {
            return progress.question!
        }
        set {
            progress.question = newValue
        }
    }
    
    // MARK: - Properties
    private var progress: Progress

    // MARK: - Initializers
    init(progress: Progress) {
        self.progress = progress
    }
}
