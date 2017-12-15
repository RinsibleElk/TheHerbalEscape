//
//  ProgressController.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 27/11/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import CoreData

/// This class manages the relationship with CoreData for tracking progress of various testable things, including flashcards.
class ProgressController: IProgressController {
    // MARK: - Private properties
    private var moc : NSManagedObjectContext
    
    // MARK: - Initializers
    init(moc: NSManagedObjectContext) {
        self.moc = moc
    }
    
    // MARK: - IProgressController
    /// Create a flashcard session for a given course.
    func createFlashcardSession(course: String, contentRepository: IContentRepository) -> IFlashcardSession {
        return FlashcardSession(randomSeed: nil, course: course, progressController: self, contentRepository: contentRepository)
    }
    
    /// Retrieve all the progress objects for a given course, ordered by due date.
    func fetchProgress(course: String?) -> [Progress] {
        // Some constants that I might configure somewhere, that determine how I will choose what to show.
        let sampleCount = 100
        var sortDescriptors = [NSSortDescriptor]()
        sortDescriptors.append(NSSortDescriptor(key: "dueDate", ascending: true))
        sortDescriptors.append(NSSortDescriptor(key: "easyCount", ascending: true))
        sortDescriptors.append(NSSortDescriptor(key: "lastDifficulty", ascending: true))
        sortDescriptors.append(NSSortDescriptor(key: "name", ascending: true))
        sortDescriptors.append(NSSortDescriptor(key: "question", ascending: true))
        let fetchRequest = NSFetchRequest<Progress>(entityName: "Progress")
        fetchRequest.sortDescriptors = sortDescriptors
        if (course != nil) {
            fetchRequest.predicate = NSPredicate(format: "course == %@", course!)
        }
        fetchRequest.fetchLimit = sampleCount
        do {
            let progressObjects = try moc.fetch(fetchRequest)
            return progressObjects
        }
        catch {
            return [Progress]()
        }
    }
    
    /// Load initial data.
    func loadInitialData(contentRepository: IContentRepository) {
        let todayDate = Date()
        for question in contentRepository.allQuestions() {
            for content in contentRepository.allContent(contentType: question.BaseContentType) {
                let entity = NSEntityDescription()
                entity.name = "Progress"
                let progress = NSManagedObject(entity: entity, insertInto: moc) as! Progress
                progress.dueDate = todayDate
                progress.easyCount = 0
                progress.lastDifficulty = 0
                progress.name = content.contentKey.ContentName
                progress.question = question.Name
            }
        }
        do {
            try moc.save()
        }
        catch {
        }
    }
}
