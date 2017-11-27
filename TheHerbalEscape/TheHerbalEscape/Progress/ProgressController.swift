//
//  ProgressController.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 27/11/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import CoreData

/// This class manages the relationship with CoreData for tracking progress of various testable things, including flashcards.
class ProgressController {
    // MARK: - Private properties
    private var moc : NSManagedObjectContext
    
    // MARK: - Initializers
    init(moc: NSManagedObjectContext) {
        self.moc = moc
    }
    
    // MARK: - API
    
}
