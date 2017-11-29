//
//  DataController.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 27/11/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import Foundation
import CoreData

/// Container for all persisted data.
class DataController: NSObject, IDataController {
    // MARK: - IDataController
    func fetchAllFlashcardProgress() -> [IFlashcardProgressModel] {
        let fetch = NSFetchRequest<FlashcardProgress>(entityName: CoreDataConstants.FlashcardProgress)
        do {
            let fetchedFlashcardProgress = try managedObjectContext.fetch(fetch)
            return fetchedFlashcardProgress.map({ (progress) -> IFlashcardProgressModel in
                return FlashcardProgressModel(flashcardProgress: progress)
            })
        }
        catch {
            NSLog("Failed to fetch flashcard progress with error \(error)")
            return []
        }
    }

    /// Create a new progress model for a flashcard name.
    func initNewFlashcardProgress(name: String) -> IFlashcardProgressModel {
        let entity = NSEntityDescription.entity(forEntityName: CoreDataConstants.FlashcardProgress, in: managedObjectContext)!
        let flashcardProgress = NSManagedObject(entity: entity, insertInto: managedObjectContext) as! FlashcardProgress
        //flashcardProgress.flashcardName = name
        flashcardProgress.easyCount = 0
        flashcardProgress.nextDate = Date()
        return FlashcardProgressModel(flashcardProgress: flashcardProgress)
    }

    /// Save all changes to the context. This suppresses errors. Errors in saving are a bit of a poor user experience, but the app can handle these in general, the user just won't have
    /// made progress today.
    func save() {
        do {
            try managedObjectContext.save()
        }
        catch {
            NSLog("Failed to save CoreData - error was \(error)")
        }
    }
    
    // MARK: - Private properties
    private var managedObjectContext: NSManagedObjectContext
    
    // MARK: - Initializers
    init(managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
    }
}
