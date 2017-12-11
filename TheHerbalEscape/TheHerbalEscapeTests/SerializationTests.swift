//
//  SerializationTests.swift
//  TheHerbalEscapeTests
//
//  Created by Oliver Samson on 10/12/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import XCTest
@testable import TheHerbalEscape

/// These tests ensure that serialization doesn't change and break the dynamic content input.
class SerializationTests: XCTestCase {
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    private func deserializeFromJsonString<T>(jsonString:String) -> (data: T?, error: Error?) where T : Decodable {
        let jsonDecoder = JSONDecoder()
        guard let data = jsonString.data(using: .utf16) else {
            return (data: nil, error: CodingError.stringToDataError)
        }
        do {
            let returnValue = try jsonDecoder.decode(T.self, from: data)
            return (data: returnValue, error: nil)
        }
        catch {
            return (data: nil, error: error)
        }
    }
    
    /// Test serialization of a test question of a Simple RelationshipType that has no images or sounds associated.
    func testSimpleQuestionNoImageNoSound() {
        let questionString = """
{
    "Name": "PlantLatinName",
    "RelationshipType": "Simple",
    "Course": "Plants",
    "BaseContentType": "Plant",
    "TargetContentType": "Plant",
    "BaseFieldName": "CommonName",
    "TargetFieldName": "LatinName",
    "FlashcardQuestion": "Latin Name",
    "ReverseFlashcardQuestion": "Common Name",
    "TestQuestion": "What is the Latin Name of $1?",
    "ReverseTestQuestion": "What is the Common Name of $1?"
}
"""
        let question: (data: Question?, error:Error?) = deserializeFromJsonString(jsonString: questionString)
        XCTAssertNotNil(question.data, "Error in decoding \(question.error!)")
        if (question.data != nil) {
            let question = question.data!
            XCTAssertEqual(question.Name, "PlantLatinName")
            XCTAssertEqual(question.RelationshipType, RelationshipType.Simple)
            XCTAssertEqual(question.Course, "Plants")
            XCTAssertEqual(question.BaseContentType, ContentType.Plant)
            XCTAssertEqual(question.TargetContentType, ContentType.Plant)
            XCTAssertEqual(question.BaseFieldName, "CommonName")
            XCTAssertEqual(question.TargetFieldName, "LatinName")
            XCTAssertEqual(question.FlashcardQuestion, "Latin Name")
            XCTAssertEqual(question.ReverseFlashcardQuestion, "Common Name")
            XCTAssertEqual(question.TestQuestion, "What is the Latin Name of $1?")
            XCTAssertEqual(question.ReverseTestQuestion, "What is the Common Name of $1?")
            XCTAssertNil(question.ImageFieldName, "The image is not nil: \(question.ImageFieldName!)")
            XCTAssertNil(question.SoundFieldName, "The sound is not nil: \(question.SoundFieldName!)")
        }
    }
    
    /// Test serialization of a test question of a Simple RelationshipType that has an image and sound associated.
    func testSimpleQuestionWithImageAndSound() {
        let questionString = """
{
    "Name": "PlantLatinName",
    "RelationshipType": "Simple",
    "Course": "Plants",
    "BaseContentType": "Plant",
    "TargetContentType": "Plant",
    "BaseFieldName": "CommonName",
    "TargetFieldName": "LatinName",
    "ImageFieldName": "ImageName",
    "SoundFieldName": "SoundName",
    "FlashcardQuestion": "Latin Name",
    "ReverseFlashcardQuestion": "Common Name",
    "TestQuestion": "What is the Latin Name of $1?",
    "ReverseTestQuestion": "What is the Common Name of $1?"
}
"""
        let question: (data: Question?, error:Error?) = deserializeFromJsonString(jsonString: questionString)
        XCTAssertNotNil(question.data, "Error in decoding \(question.error!)")
        if (question.data != nil) {
            let question = question.data!
            XCTAssertEqual(question.Name, "PlantLatinName")
            XCTAssertEqual(question.RelationshipType, RelationshipType.Simple)
            XCTAssertEqual(question.Course, "Plants")
            XCTAssertEqual(question.BaseContentType, ContentType.Plant)
            XCTAssertEqual(question.TargetContentType, ContentType.Plant)
            XCTAssertEqual(question.BaseFieldName, "CommonName")
            XCTAssertEqual(question.TargetFieldName, "LatinName")
            XCTAssertEqual(question.FlashcardQuestion, "Latin Name")
            XCTAssertEqual(question.ReverseFlashcardQuestion, "Common Name")
            XCTAssertEqual(question.TestQuestion, "What is the Latin Name of $1?")
            XCTAssertEqual(question.ReverseTestQuestion, "What is the Common Name of $1?")
            XCTAssertEqual(question.ImageFieldName, "ImageName")
            XCTAssertEqual(question.SoundFieldName, "SoundName")
        }
    }
}
