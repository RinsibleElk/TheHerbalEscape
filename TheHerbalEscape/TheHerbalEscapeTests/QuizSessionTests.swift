//
//  QuizSessionTests.swift
//  TheHerbalEscapeTests
//
//  Created by Oliver Samson on 06/01/2018.
//  Copyright © 2018 Oliver Samson. All rights reserved.
//

import XCTest
@testable import TheHerbalEscape

class QuizSessionTests: XCTestCase {
    var contentRepository: IContentRepository?
    var progressController: IProgressController?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        contentRepository = FakeContentRepository()
        progressController = FakeProgressController()
        progressController!.loadInitialData(contentRepository: contentRepository!)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        contentRepository = nil
        progressController = nil
    }
    
    func testCreateFirstEverSession() {
        // Create a fake content repo, initialize progress controller with everything due.
        // Create a quiz session.
        // Check the chosen questions and answers.
        let quizSession = QuizSession(randomSeed: 12345, course: nil, progressController: progressController!, contentRepository: contentRepository!)
        var allQuizQuestions = [QuizQuestion]()
        while quizSession.hasMoreQuestionsToShow {
            allQuizQuestions.append(quizSession.currentQuestion)
            quizSession.finishQuestion(wasCorrect: true)
        }

        XCTAssertEqual(allQuizQuestions.count, 10, "Wrong number of quiz questions")

        var index = 0
        XCTAssertEqual(allQuizQuestions[index].Answers.count, 4, "Wrong number of answers")
        XCTAssertEqual(allQuizQuestions[index].Answers[0].Answer, "Knautia arvensis", "Answer wrong")
        XCTAssertTrue(allQuizQuestions[index].Answers[0].IsCorrect, "IsCorrect wrong")
        XCTAssertEqual(allQuizQuestions[index].Answers[1].Answer, "Pelargonium sidoides", "Answer wrong")
        XCTAssertFalse(allQuizQuestions[index].Answers[1].IsCorrect, "IsCorrect wrong")
        XCTAssertEqual(allQuizQuestions[index].Answers[2].Answer, "Psidium guajava", "Answer wrong")
        XCTAssertFalse(allQuizQuestions[index].Answers[2].IsCorrect, "IsCorrect wrong")
        XCTAssertEqual(allQuizQuestions[index].Answers[3].Answer, "Nelumbo nucifera", "Answer wrong")
        XCTAssertFalse(allQuizQuestions[index].Answers[3].IsCorrect, "IsCorrect wrong")
        XCTAssertEqual(allQuizQuestions[index].Color, CourseColor.Azure, "Colour wrong")
        XCTAssertEqual(allQuizQuestions[index].QuestionName, "PlantLatinName", "QuestionName wrong")
        XCTAssertEqual(allQuizQuestions[index].ContentName, "Field scabious", "ContentName wrong")
        XCTAssertEqual(allQuizQuestions[index].Question, "What is the latin name of Field scabious?", "Question wrong")
        XCTAssertFalse(allQuizQuestions[index].SupportsMultipleSelection, "SupportsMultipleSelection wrong")
        
        index = 1
        XCTAssertEqual(allQuizQuestions[index].Answers.count, 4, "Wrong number of answers")
        XCTAssertEqual(allQuizQuestions[index].Answers[0].Answer, "Aquifoliaceae", "Answer wrong")
        XCTAssertFalse(allQuizQuestions[index].Answers[0].IsCorrect, "IsCorrect wrong")
        XCTAssertEqual(allQuizQuestions[index].Answers[1].Answer, "Elaeagnaceae", "Answer wrong")
        XCTAssertFalse(allQuizQuestions[index].Answers[1].IsCorrect, "IsCorrect wrong")
        XCTAssertEqual(allQuizQuestions[index].Answers[2].Answer, "Solanaceae", "Answer wrong")
        XCTAssertTrue(allQuizQuestions[index].Answers[2].IsCorrect, "IsCorrect wrong")
        XCTAssertEqual(allQuizQuestions[index].Answers[3].Answer, "Asphodelaceae", "Answer wrong")
        XCTAssertFalse(allQuizQuestions[index].Answers[3].IsCorrect, "IsCorrect wrong")
        XCTAssertEqual(allQuizQuestions[index].Color, CourseColor.Azure, "Colour wrong")
        XCTAssertEqual(allQuizQuestions[index].QuestionName, "PlantHerbalFamily", "QuestionName wrong")
        XCTAssertEqual(allQuizQuestions[index].ContentName, "Belladonna", "ContentName wrong")
        XCTAssertEqual(allQuizQuestions[index].Question, "What is the herbal family of Belladonna?", "Question wrong")
        XCTAssertFalse(allQuizQuestions[index].SupportsMultipleSelection, "SupportsMultipleSelection wrong")
        
        index = 2
        XCTAssertEqual(allQuizQuestions[index].Answers.count, 4, "Wrong number of answers")
        XCTAssertEqual(allQuizQuestions[index].Answers[0].Answer, "Asteraceae", "Answer wrong")
        XCTAssertFalse(allQuizQuestions[index].Answers[0].IsCorrect, "IsCorrect wrong")
        XCTAssertEqual(allQuizQuestions[index].Answers[1].Answer, "Lamiaceae", "Answer wrong")
        XCTAssertTrue(allQuizQuestions[index].Answers[1].IsCorrect, "IsCorrect wrong")
        XCTAssertEqual(allQuizQuestions[index].Answers[2].Answer, "Polygonaceae", "Answer wrong")
        XCTAssertFalse(allQuizQuestions[index].Answers[2].IsCorrect, "IsCorrect wrong")
        XCTAssertEqual(allQuizQuestions[index].Answers[3].Answer, "Rutaceae", "Answer wrong")
        XCTAssertFalse(allQuizQuestions[index].Answers[3].IsCorrect, "IsCorrect wrong")
        XCTAssertEqual(allQuizQuestions[index].Color, CourseColor.Azure, "Colour wrong")
        XCTAssertEqual(allQuizQuestions[index].QuestionName, "PlantHerbalFamily", "QuestionName wrong")
        XCTAssertEqual(allQuizQuestions[index].ContentName, "Summer savory", "ContentName wrong")
        XCTAssertEqual(allQuizQuestions[index].Question, "What is the herbal family of Summer savory?", "Question wrong")
        XCTAssertFalse(allQuizQuestions[index].SupportsMultipleSelection, "SupportsMultipleSelection wrong")
        
        index = 3
        XCTAssertEqual(allQuizQuestions[index].Answers.count, 4, "Wrong number of answers")
        XCTAssertEqual(allQuizQuestions[index].Answers[0].Answer, "São Caetano melon", "Answer wrong")
        XCTAssertFalse(allQuizQuestions[index].Answers[0].IsCorrect, "IsCorrect wrong")
        XCTAssertEqual(allQuizQuestions[index].Answers[1].Answer, "Ashwagandha", "Answer wrong")
        XCTAssertTrue(allQuizQuestions[index].Answers[1].IsCorrect, "IsCorrect wrong")
        XCTAssertEqual(allQuizQuestions[index].Answers[2].Answer, "Common witch-hazel", "Answer wrong")
        XCTAssertFalse(allQuizQuestions[index].Answers[2].IsCorrect, "IsCorrect wrong")
        XCTAssertEqual(allQuizQuestions[index].Answers[3].Answer, "Sea buckthorn", "Answer wrong")
        XCTAssertFalse(allQuizQuestions[index].Answers[3].IsCorrect, "IsCorrect wrong")
        XCTAssertEqual(allQuizQuestions[index].Color, CourseColor.Azure, "Colour wrong")
        XCTAssertEqual(allQuizQuestions[index].QuestionName, "PlantLatinName", "QuestionName wrong")
        XCTAssertEqual(allQuizQuestions[index].ContentName, "Ashwagandha", "ContentName wrong")
        XCTAssertEqual(allQuizQuestions[index].Question, "What is the common name of Withania somnifera?", "Question wrong")
        XCTAssertFalse(allQuizQuestions[index].SupportsMultipleSelection, "SupportsMultipleSelection wrong")
        
        index = 4
        XCTAssertEqual(allQuizQuestions[index].Answers.count, 4, "Wrong number of answers")
        XCTAssertEqual(allQuizQuestions[index].Answers[0].Answer, "Cotton lavender", "Answer wrong")
        XCTAssertFalse(allQuizQuestions[index].Answers[0].IsCorrect, "IsCorrect wrong")
        XCTAssertEqual(allQuizQuestions[index].Answers[1].Answer, "Common mullein", "Answer wrong")
        XCTAssertFalse(allQuizQuestions[index].Answers[1].IsCorrect, "IsCorrect wrong")
        XCTAssertEqual(allQuizQuestions[index].Answers[2].Answer, "Sea buckthorn", "Answer wrong")
        XCTAssertTrue(allQuizQuestions[index].Answers[2].IsCorrect, "IsCorrect wrong")
        XCTAssertEqual(allQuizQuestions[index].Answers[3].Answer, "Magnolia-bark", "Answer wrong")
        XCTAssertFalse(allQuizQuestions[index].Answers[3].IsCorrect, "IsCorrect wrong")
        XCTAssertEqual(allQuizQuestions[index].Color, CourseColor.Azure, "Colour wrong")
        XCTAssertEqual(allQuizQuestions[index].QuestionName, "PlantHerbalFamily", "QuestionName wrong")
        XCTAssertEqual(allQuizQuestions[index].ContentName, "Sea buckthorn", "ContentName wrong")
        XCTAssertEqual(allQuizQuestions[index].Question, "Which of these plants are in the herbal family Elaeagnaceae?", "Question wrong")
        XCTAssertTrue(allQuizQuestions[index].SupportsMultipleSelection, "SupportsMultipleSelection wrong")
        
        index = 5
        XCTAssertEqual(allQuizQuestions[index].Answers.count, 4, "Wrong number of answers")
        XCTAssertEqual(allQuizQuestions[index].Answers[0].Answer, "Viscum album", "Answer wrong")
        XCTAssertTrue(allQuizQuestions[index].Answers[0].IsCorrect, "IsCorrect wrong")
        XCTAssertEqual(allQuizQuestions[index].Answers[1].Answer, "Linum usitatissimum", "Answer wrong")
        XCTAssertFalse(allQuizQuestions[index].Answers[1].IsCorrect, "IsCorrect wrong")
        XCTAssertEqual(allQuizQuestions[index].Answers[2].Answer, "Moringa oleifera", "Answer wrong")
        XCTAssertFalse(allQuizQuestions[index].Answers[2].IsCorrect, "IsCorrect wrong")
        XCTAssertEqual(allQuizQuestions[index].Answers[3].Answer, "Lawsonia inermis", "Answer wrong")
        XCTAssertFalse(allQuizQuestions[index].Answers[3].IsCorrect, "IsCorrect wrong")
        XCTAssertEqual(allQuizQuestions[index].Color, CourseColor.Azure, "Colour wrong")
        XCTAssertEqual(allQuizQuestions[index].QuestionName, "PlantLatinName", "QuestionName wrong")
        XCTAssertEqual(allQuizQuestions[index].ContentName, "European mistletoe", "ContentName wrong")
        XCTAssertEqual(allQuizQuestions[index].Question, "What is the latin name of European mistletoe?", "Question wrong")
        XCTAssertFalse(allQuizQuestions[index].SupportsMultipleSelection, "SupportsMultipleSelection wrong")
        
        index = 6
        XCTAssertEqual(allQuizQuestions[index].Answers.count, 4, "Wrong number of answers")
        XCTAssertEqual(allQuizQuestions[index].Answers[0].Answer, "Opium poppy", "Answer wrong")
        XCTAssertTrue(allQuizQuestions[index].Answers[0].IsCorrect, "IsCorrect wrong")
        XCTAssertEqual(allQuizQuestions[index].Answers[1].Answer, "Garlic", "Answer wrong")
        XCTAssertFalse(allQuizQuestions[index].Answers[1].IsCorrect, "IsCorrect wrong")
        XCTAssertEqual(allQuizQuestions[index].Answers[2].Answer, "Field scabious", "Answer wrong")
        XCTAssertFalse(allQuizQuestions[index].Answers[2].IsCorrect, "IsCorrect wrong")
        XCTAssertEqual(allQuizQuestions[index].Answers[3].Answer, "Californian poppy", "Answer wrong")
        XCTAssertTrue(allQuizQuestions[index].Answers[3].IsCorrect, "IsCorrect wrong")
        XCTAssertEqual(allQuizQuestions[index].Color, CourseColor.Azure, "Colour wrong")
        XCTAssertEqual(allQuizQuestions[index].QuestionName, "PlantHerbalFamily", "QuestionName wrong")
        XCTAssertEqual(allQuizQuestions[index].ContentName, "Californian poppy", "ContentName wrong")
        XCTAssertEqual(allQuizQuestions[index].Question, "Which of these plants are in the herbal family Papaveraceae?", "Question wrong")
        XCTAssertTrue(allQuizQuestions[index].SupportsMultipleSelection, "SupportsMultipleSelection wrong")
        
        index = 7
        XCTAssertEqual(allQuizQuestions[index].Answers.count, 4, "Wrong number of answers")
        XCTAssertEqual(allQuizQuestions[index].Answers[0].Answer, "Agrimonia eupatoria", "Answer wrong")
        XCTAssertTrue(allQuizQuestions[index].Answers[0].IsCorrect, "IsCorrect wrong")
        XCTAssertEqual(allQuizQuestions[index].Answers[1].Answer, "Lawsonia inermis", "Answer wrong")
        XCTAssertFalse(allQuizQuestions[index].Answers[1].IsCorrect, "IsCorrect wrong")
        XCTAssertEqual(allQuizQuestions[index].Answers[2].Answer, "Crataegus monogyna", "Answer wrong")
        XCTAssertFalse(allQuizQuestions[index].Answers[2].IsCorrect, "IsCorrect wrong")
        XCTAssertEqual(allQuizQuestions[index].Answers[3].Answer, "Illicium verum", "Answer wrong")
        XCTAssertFalse(allQuizQuestions[index].Answers[3].IsCorrect, "IsCorrect wrong")
        XCTAssertEqual(allQuizQuestions[index].Color, CourseColor.Azure, "Colour wrong")
        XCTAssertEqual(allQuizQuestions[index].QuestionName, "PlantLatinName", "QuestionName wrong")
        XCTAssertEqual(allQuizQuestions[index].ContentName, "Agrimony", "ContentName wrong")
        XCTAssertEqual(allQuizQuestions[index].Question, "What is the latin name of Agrimony?", "Question wrong")
        XCTAssertFalse(allQuizQuestions[index].SupportsMultipleSelection, "SupportsMultipleSelection wrong")
        
        index = 8
        XCTAssertEqual(allQuizQuestions[index].Answers.count, 4, "Wrong number of answers")
        XCTAssertEqual(allQuizQuestions[index].Answers[0].Answer, "Vitis vinifera", "Answer wrong")
        XCTAssertFalse(allQuizQuestions[index].Answers[0].IsCorrect, "IsCorrect wrong")
        XCTAssertEqual(allQuizQuestions[index].Answers[1].Answer, "Eschscholzia californica", "Answer wrong")
        XCTAssertFalse(allQuizQuestions[index].Answers[1].IsCorrect, "IsCorrect wrong")
        XCTAssertEqual(allQuizQuestions[index].Answers[2].Answer, "Strobilanthes callosus", "Answer wrong")
        XCTAssertFalse(allQuizQuestions[index].Answers[2].IsCorrect, "IsCorrect wrong")
        XCTAssertEqual(allQuizQuestions[index].Answers[3].Answer, "Passiflora", "Answer wrong")
        XCTAssertTrue(allQuizQuestions[index].Answers[3].IsCorrect, "IsCorrect wrong")
        XCTAssertEqual(allQuizQuestions[index].Color, CourseColor.Azure, "Colour wrong")
        XCTAssertEqual(allQuizQuestions[index].QuestionName, "PlantLatinName", "QuestionName wrong")
        XCTAssertEqual(allQuizQuestions[index].ContentName, "Passion flower", "ContentName wrong")
        XCTAssertEqual(allQuizQuestions[index].Question, "What is the latin name of Passion flower?", "Question wrong")
        XCTAssertFalse(allQuizQuestions[index].SupportsMultipleSelection, "SupportsMultipleSelection wrong")
        
        index = 9
        XCTAssertEqual(allQuizQuestions[index].Answers.count, 4, "Wrong number of answers")
        XCTAssertEqual(allQuizQuestions[index].Answers[0].Answer, "Geraniaceae", "Answer wrong")
        XCTAssertTrue(allQuizQuestions[index].Answers[0].IsCorrect, "IsCorrect wrong")
        XCTAssertEqual(allQuizQuestions[index].Answers[1].Answer, "Linaceae", "Answer wrong")
        XCTAssertFalse(allQuizQuestions[index].Answers[1].IsCorrect, "IsCorrect wrong")
        XCTAssertEqual(allQuizQuestions[index].Answers[2].Answer, "Asteraceae", "Answer wrong")
        XCTAssertFalse(allQuizQuestions[index].Answers[2].IsCorrect, "IsCorrect wrong")
        XCTAssertEqual(allQuizQuestions[index].Answers[3].Answer, "Commelinaceae", "Answer wrong")
        XCTAssertFalse(allQuizQuestions[index].Answers[3].IsCorrect, "IsCorrect wrong")
        XCTAssertEqual(allQuizQuestions[index].Color, CourseColor.Azure, "Colour wrong")
        XCTAssertEqual(allQuizQuestions[index].QuestionName, "PlantHerbalFamily", "QuestionName wrong")
        XCTAssertEqual(allQuizQuestions[index].ContentName, "Umckaloabo", "ContentName wrong")
        XCTAssertEqual(allQuizQuestions[index].Question, "What is the herbal family of Umckaloabo?", "Question wrong")
        XCTAssertFalse(allQuizQuestions[index].SupportsMultipleSelection, "SupportsMultipleSelection wrong")
    }
}
