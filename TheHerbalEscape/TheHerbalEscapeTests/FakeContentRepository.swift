//
//  FakeContentRepository.swift
//  TheHerbalEscapeTests
//
//  Created by Oliver Samson on 06/01/2018.
//  Copyright © 2018 Oliver Samson. All rights reserved.
//

import Foundation
import XCTest
@testable import TheHerbalEscape

class FakeContentRepository: IContentRepository {
    // MARK: - Properties
    var Questions = [String:Question]()
    var Contents = [ContentKey:Content]()
    var Courses = [String:Course]()

    // MARK: - IContentRepository
    var Browsables: [Browsable]
    
    func fetchQuestion(question: String) -> Question {
        return Questions[question]!
    }
    
    func fetchContent(contentKey: ContentKey) -> Content {
        return Contents[contentKey]!
    }
    
    func fetchCourse(courseName: String) -> Course {
        return Courses[courseName]!
    }
    func allQuestions() -> [Question] {
        var questions = [Question]()
        for kvp in Questions {
            questions.append(kvp.value)
        }
        return questions
    }
    
    func allContent(contentType: ContentType) -> [Content] {
        var content = [Content]()
        for kvp in Contents {
            if (kvp.key.ContentType == contentType) {
                content.append(kvp.value)
            }
        }
        return content
    }

    // MARK: - Initializers
    init() {
        Browsables = []
        // Hack in some dummy content for now.
        let plantsUrl = DataManager.urlForResource("LevelOne", "plants", "json")
        let herbalActionsUrl = DataManager.urlForResource("Global", "actions", "json")
        let herbalFamiliesUrl = DataManager.urlForResource("Global", "herbalfamilies", "json")
        let questionsUrl = DataManager.urlForResource("LevelOne", "questions", "json")
        let coursesUrl = DataManager.urlForResource("LevelOne", "courses", "json")
        DataManager.getContents(coursesUrl) { (data, error) in
            if let data = data {
                let courses = CourseContents.decodeFromJSON(jsonData: data)
                for course in courses {
                    self.Courses[course.Name] = course
                }
            }
        }
        var remaining = 0
        remaining = remaining + 1
        remaining = remaining + 1
        remaining = remaining + 1
        remaining = remaining + 1
        DataManager.getContents(plantsUrl) { (data, error) in
            remaining = remaining - 1
            if let data = data {
                let plants = PlantContents.decodeFromJSON(jsonData: data)
                for plant in plants {
                    self.Browsables.append(plant)
                    self.Contents[plant.contentKey] = plant
                }
            }
        }
        DataManager.getContents(herbalActionsUrl) { (data, error) in
            remaining = remaining - 1
            if let data = data {
                let actions = HerbalActionContents.decodeFromJSON(jsonData: data)
                for action in actions {
                    self.Browsables.append(action)
                    self.Contents[action.contentKey] = action
                }
            }
        }
        DataManager.getContents(herbalFamiliesUrl) { (data, error) in
            remaining = remaining - 1
            if let data = data {
                let families = HerbalFamilyContents.decodeFromJSON(jsonData: data)
                for family in families {
                    self.Browsables.append(family)
                    self.Contents[family.contentKey] = family
                }
            }
        }
        DataManager.getContents(questionsUrl) { (data, error) in
            remaining = remaining - 1
            if let data = data {
                let questions = QuestionContents.decodeFromJSON(jsonData: data)
                for question in questions {
                    self.Questions[question.Name] = question
                }
            }
        }
    }
}
