//
//  FlashcardSessionTests.swift
//  TheHerbalEscapeTests
//
//  Created by Oliver Samson on 27/11/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import XCTest
@testable import TheHerbalEscape

class FlashcardSessionTests: XCTestCase {
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
        // Create a flashcard session.
        // Check the chosen cards.
        let flashcardSession = FlashcardSession(randomSeed: 12345, course: nil, progressController: progressController!, contentRepository: contentRepository!)
        let flashcards = flashcardSession.flashcards
        XCTAssertEqual(flashcards.count, 10, "Wrong number of flashcards")
        XCTAssertEqual(flashcards[0].Front.Color, CourseColor.Azure, "Wrong course colour")
        XCTAssertEqual(flashcards[0].Front.Question!, "Latin Name?", "Wrong question")
        XCTAssertEqual(flashcards[0].Front.Text, "Field scabious", "Wrong text")
    }
}
