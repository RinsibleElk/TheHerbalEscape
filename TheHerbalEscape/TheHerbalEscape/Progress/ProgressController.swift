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
    func createFlashcardSession(course: String?, contentRepository: IContentRepository) -> IFlashcardSession {
        return FlashcardSession(randomSeed: nil, course: course, progressController: self, contentRepository: contentRepository)
    }
    
    /// Create a new quiz session for a given course.
    func createQuizSession(course:String?, contentRepository: IContentRepository) -> IQuizSession {
        return QuizSession(randomSeed: nil, course: course, progressController: self, contentRepository: contentRepository)
    }

    
    /// Save after changes.
    func save() throws {
        try moc.save()
    }
    
    /// Retrieve the progress object for a given key.
    func fetchProgress(progressKey: ProgressKey) -> IProgressFacade? {
        let fetchRequest = NSFetchRequest<Progress>(entityName: "Progress")
        let sampleCount = 1
        fetchRequest.predicate = NSPredicate(format: "(question == %@) AND (name == %@)", progressKey.question, progressKey.name)
        fetchRequest.fetchLimit = sampleCount
        do {
            let progressObjects = try moc.fetch(fetchRequest)
            if progressObjects.count > 0 {
                return ProgressFacade(progress: progressObjects[0])
            }
            else {
                return nil
            }
        }
        catch {
            return nil
        }
    }
    
    /// Retrieve all the progress objects for a given course, ordered by due date.
    func fetchProgress(course: String?) -> [IProgressFacade] {
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
            return progressObjects.map({ (progress) -> IProgressFacade in
                return ProgressFacade(progress: progress)
            })
        }
        catch {
            return [IProgressFacade]()
        }
    }
    
    /// Load initial data.
    func loadInitialData(contentRepository: IContentRepository) {
        let todayDate = Date()
        let veryHardInt16 = FlashcardDifficulty.veryHard.toInt16()
        for question in contentRepository.allQuestions() {
            for content in contentRepository.allContent(contentType: question.BaseContentType) {
                let entity = NSEntityDescription.entity(forEntityName: "Progress", in: moc)!
                let progress = NSManagedObject(entity: entity, insertInto: moc) as! Progress
                progress.dueDate = todayDate
                progress.easyCount = 0
                progress.lastDifficulty = veryHardInt16
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
    
    /// Get the overall progress.
    func getProgressSummary(contentRepository: IContentRepository) -> OverallProgressSummary {
        let fetchRequest = NSFetchRequest<Progress>(entityName: "Progress")
        let progressSummary = OverallProgressSummary()
        do {
            let progressObjects = try moc.fetch(fetchRequest)
            for progress in progressObjects {
                let content = contentRepository.fetchQuestion(question: progress.question!)
                progressSummary.update(course: content.Course, oldValue: nil, newValue: progress.lastDifficulty.toDifficulty())
            }
            return progressSummary
        }
        catch {
            return progressSummary
        }
    }
}
