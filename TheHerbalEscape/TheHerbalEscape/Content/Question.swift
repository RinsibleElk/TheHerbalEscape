//
//  Question.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 10/12/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import Foundation

/// Represents a question that can test a relationship. It can be posed in a multiple choice test or flashcard setting.
class Question: Codable {
    /// A unique name for this question.
    /// This is used as the key in progress tracking.
    var Name: String
    
    /// The type of relationship under test.
    /// Options are: Simple, ManyToOne, ManyToMany
    var RelationshipType: RelationshipType

    /// The Course that this Question is in.
    var Course: String
    
    /// The entity that this field is on.
    var BaseContentType: ContentType

    /// The target entity.
    /// In the case of a simple relationship (property), this refers to the same entity as the BaseEntity.
    var TargetContentType: ContentType
    
    /// The name of the field on the BaseEntity used to determine the answer to the question.
    var BaseFieldName: String
    
    /// The name of the field on the TargetEntity used to determine the answer to the question.
    var TargetFieldName: String
    
    /// Optional image to show. This is the field name on the BaseEntity that determines the image for Flashcard FrontSide and ReverseFlashcard RearSide.
    var FlashcardQuestionImageFieldName: String?

    /// Optional image to show in answers to reverse test questions on this entity.
    var ReverseTestAnswerImageFieldName: String?

    /// Optional sound to play. This is the field name on the BaseEntity that determines this sound. This is used only if the user has enabled sound in their Preferences.
    /// This is played in:
    /// - ReverseFlashcard FrontSide
    var SoundFieldName: String?
    
    /// Flashcard question. This determines the phrasing of the question on a Flashcard. This goes at the top of the card, and is independent of the entity chosen.
    var FlashcardQuestion: String
    
    /// Reverse Flashcard question. This determines the phrasing of the question on a Flashcard. This goes at the top of the card, and is independent of the entity chosen.
    /// This is only used for RelationshipType Simple.
    var ReverseFlashcardQuestion: String?
    
    /// Test question. This determines the phrasing of the question in a test.
    /// This can include the variable $1 which will refer to the name of the base entity.
    var TestQuestion: String
    
    /// Optional reverse test question. This determines the phrasing of the reverse question in a test.
    /// This can include the variable $1 which will refer to the target value.
    var ReverseTestQuestion: String?
}

public class QuestionContents : Decodable {
    var Questions: [Question]
    static func decodeFromJSON(jsonData: Data) -> [Question] {
        let jsonDecoder = JSONDecoder()
        do {
            let questions = try jsonDecoder.decode(QuestionContents.self, from: jsonData)
            return questions.Questions
        }
        catch {
            return []
        }
    }
}
