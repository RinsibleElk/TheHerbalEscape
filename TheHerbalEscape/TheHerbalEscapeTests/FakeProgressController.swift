//
//  FakeProgressController.swift
//  TheHerbalEscapeTests
//
//  Created by Oliver Samson on 06/01/2018.
//  Copyright © 2018 Oliver Samson. All rights reserved.
//

import Foundation
import XCTest
@testable import TheHerbalEscape

class FakeProgressController: IProgressController {
    // MARK: - Properties
    var progress = [FakeProgressKey:IProgressFacade]()
    var randomSeed: UInt64 = 0

    // MARK: - IProgressController
    func createFlashcardSession(course: String?, contentRepository: IContentRepository) -> IFlashcardSession {
        return FlashcardSession(randomSeed: randomSeed, course: course, progressController: self, contentRepository: contentRepository)
    }
    
    func createQuizSession(course: String?, contentRepository: IContentRepository) -> IQuizSession {
        return QuizSession(randomSeed: randomSeed, course: course, progressController: self, contentRepository: contentRepository)
    }
    
    func fetchProgress(course: String?) -> [IProgressFacade] {
        return Array(progress.values)
    }

    func fetchProgress(progressKey: ProgressKey) -> IProgressFacade? {
        return progress[FakeProgressKey(question: progressKey.question, name: progressKey.name)]
    }
    
    func loadInitialData(contentRepository: IContentRepository) {
        let todayDate = Date(year: 2017, month: 11, day: 10)
        for question in contentRepository.allQuestions() {
            for content in contentRepository.allContent(contentType: question.BaseContentType) {
                let progressObject = FakeProgressFacade(dueDate: todayDate, easyCount: 0, lastDifficulty: .veryHard, name: content.contentKey.ContentName, question: question.Name)
                let key = FakeProgressKey(question: question.Name, name: content.contentKey.ContentName)
                self.progress[key] = progressObject
            }
        }
    }
    
    func save() throws {
    }
    
    func getProgressSummary(contentRepository: IContentRepository) -> OverallProgressSummary {
        let progressSummary = OverallProgressSummary()
        for progressObject in progress {
            let content = contentRepository.fetchQuestion(question: progressObject.value.question)
            progressSummary.update(course: content.Course, oldValue: nil, newValue: progressObject.value.lastDifficulty)
        }
        return progressSummary
    }
}
