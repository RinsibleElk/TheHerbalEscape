//
//  ContentRepository.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 25/11/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import Foundation

/// Repository with all the content in it.
/// Very eager for the minute. Meh.
class ContentRepository: IContentRepository {
    var Browsables = [Browsable]()
    var Questions = [String:Question]()
    var Contents = [ContentKey:Content]()
    var Courses = [String:Course]()
    
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
}
