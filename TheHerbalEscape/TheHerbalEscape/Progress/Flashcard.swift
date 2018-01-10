//
//  Flashcard.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 14/12/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import Foundation

/// Tracks a flashcard that is currently in use in a session.
class Flashcard: Codable, ProgressKey {
    // MARK: - ProgressKey
    var question: String { get { return Question }}
    var name: String { get { return Name }}
    
    // MARK: - Properties
    var Result: FlashcardDifficulty?
    var Front: FlashcardSide
    var Back: FlashcardSide
    var Question: String
    var Name: String
    
    // MARK: - Initializers
    init(contentRepository:IContentRepository, reverseSide: Bool, question: Question, name: String) {
        let contentType = question.BaseContentType
        let contentKey = ContentKey(contentType: contentType, contentName: name)
        let content = contentRepository.fetchContent(contentKey: contentKey)
        let questionText = content.getValue(name: question.BaseFieldName)!
        let questionImage = (question.FlashcardQuestionImageFieldName != nil) ? content.getValue(name: question.FlashcardQuestionImageFieldName!) : nil
        let answerSound = (question.SoundFieldName != nil) ? content.getValue(name: question.SoundFieldName!) : nil
        let course = contentRepository.fetchCourse(courseName: question.Course)
        var answerText : String
        switch question.RelationshipType {
        case .Simple:
            answerText = content.getValue(name: question.TargetFieldName)!
        case .ManyToOne:
            answerText = content.getValue(name: question.TargetFieldName)!
        case .ManyToMany:
            answerText = ""
            for answer in content.getValues(name: question.TargetFieldName) {
                if (answerText == "") {
                    answerText = answer
                }
                else {
                    answerText += "\n\(answer)"
                }
            }
        }
        Result = nil
        if (reverseSide) {
            Front = FlashcardSide(color: course.Color, question: question.ReverseFlashcardQuestion!, text: answerText, imageName: nil, soundName: answerSound)
            Back = FlashcardSide(color: course.Color, question: "", text: questionText, imageName: questionImage, soundName: nil)
        }
        else {
            Front = FlashcardSide(color: course.Color, question: question.FlashcardQuestion, text: questionText, imageName: questionImage, soundName: nil)
            Back = FlashcardSide(color: course.Color, question: "", text: answerText, imageName: nil, soundName: answerSound)
        }
        Question = question.Name
        Name = name
    }
}
