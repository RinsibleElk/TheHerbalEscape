//
//  BrowserTextTests.swift
//  TheHerbalEscapeTests
//
//  Created by Oliver Samson on 02/12/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import XCTest
@testable import TheHerbalEscape

class BrowserTextTests: XCTestCase {
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    /// Split paragraphs out of a string with two paragraphs.
    func testSplitParagraphs() {
        let text = """
Hello world.

Alright?
"""
        let layout = BrowserTextLayout(text)
        XCTAssertEqual(layout.paragraphs.count, 2)
        let paragraph1 = layout.paragraphs[0]
        let paragraph2 = layout.paragraphs[1]
        XCTAssertEqual(paragraph1.text, "Hello world.")
        XCTAssertEqual(paragraph1.links.count, 0)
        XCTAssertEqual(paragraph1.highlights.count, 1)
        XCTAssertEqual(paragraph1.highlights[0].range.location, 0)
        XCTAssertEqual(paragraph1.highlights[0].range.length, 12)
        XCTAssertEqual(paragraph1.highlights[0].highlightTypes, [])
        XCTAssertEqual(paragraph2.text, "Alright?")
        XCTAssertEqual(paragraph2.links.count, 0)
        XCTAssertEqual(paragraph2.highlights.count, 1)
        XCTAssertEqual(paragraph2.highlights[0].range.location, 0)
        XCTAssertEqual(paragraph2.highlights[0].range.length, 8)
        XCTAssertEqual(paragraph2.highlights[0].highlightTypes, [])
    }
    
    /// Create a paragraph with a single link.
    func testSingleLink() {
        let text = """
Here is a [LinkText](). I will interpret the link destination as the same as the inner string.
"""
        let layout = BrowserTextLayout(text)
        XCTAssertEqual(layout.paragraphs.count, 1)
        let paragraph = layout.paragraphs[0]
        XCTAssertEqual(paragraph.text, "Here is a LinkText. I will interpret the link destination as the same as the inner string.")
        XCTAssertEqual(paragraph.highlights.count, 3)
        if (paragraph.highlights.count == 3) {
            let highlight1 = paragraph.highlights[0]
            let highlight2 = paragraph.highlights[1]
            let highlight3 = paragraph.highlights[2]
            XCTAssertEqual(highlight1.range.location, 0)
            XCTAssertEqual(highlight1.range.length, 10)
            XCTAssertEqual(highlight1.highlightTypes, [])
            XCTAssertEqual(highlight2.range.location, 10)
            XCTAssertEqual(highlight2.range.length, 8)
            XCTAssertEqual(highlight2.highlightTypes, [.link])
            XCTAssertEqual(highlight3.range.location, 18)
            XCTAssertEqual(highlight3.range.length, 72)
            XCTAssertEqual(highlight3.highlightTypes, [])
            XCTAssertEqual(paragraph.links.count, 1)
            if (paragraph.links.count == 1) {
                let link = paragraph.links[0]
                XCTAssertEqual(link.range.location, 10)
                XCTAssertEqual(link.range.length, 8)
                XCTAssertEqual(link.target, "LinkText")
            }
        }
    }

    
    /// Create a paragraph with two links.
    func testTwoLinks() {
        let text = """
Here is a [LinkText](). And here is [Another]().
"""
        let layout = BrowserTextLayout(text)
        XCTAssertEqual(layout.paragraphs.count, 1)
        let paragraph = layout.paragraphs[0]
        XCTAssertEqual(paragraph.text, "Here is a LinkText. And here is Another.")
        XCTAssertEqual(paragraph.highlights.count, 5)
        if (paragraph.highlights.count == 5) {
            let highlight1 = paragraph.highlights[0]
            let highlight2 = paragraph.highlights[1]
            let highlight3 = paragraph.highlights[2]
            let highlight4 = paragraph.highlights[3]
            let highlight5 = paragraph.highlights[4]
            XCTAssertEqual(highlight1.range.location, 0)
            XCTAssertEqual(highlight1.range.length, 10)
            XCTAssertEqual(highlight1.highlightTypes, [])
            XCTAssertEqual(highlight2.range.location, 10)
            XCTAssertEqual(highlight2.range.length, 8)
            XCTAssertEqual(highlight2.highlightTypes, [.link])
            XCTAssertEqual(highlight3.range.location, 18)
            XCTAssertEqual(highlight3.range.length, 14)
            XCTAssertEqual(highlight3.highlightTypes, [])
            XCTAssertEqual(highlight4.range.location, 32)
            XCTAssertEqual(highlight4.range.length, 7)
            XCTAssertEqual(highlight4.highlightTypes, [.link])
            XCTAssertEqual(highlight5.range.location, 39)
            XCTAssertEqual(highlight5.range.length, 1)
            XCTAssertEqual(highlight5.highlightTypes, [])
            XCTAssertEqual(paragraph.links.count, 2)
            if (paragraph.links.count == 2) {
                let link1 = paragraph.links[0]
                let link2 = paragraph.links[1]
                XCTAssertEqual(link1.range.location, 10)
                XCTAssertEqual(link1.range.length, 8)
                XCTAssertEqual(link1.target, "LinkText")
                XCTAssertEqual(link2.range.location, 32)
                XCTAssertEqual(link2.range.length, 7)
                XCTAssertEqual(link2.target, "Another")
            }
        }
    }
    
    /// Create a paragraph with some bold text.
    func testSingleBold() {
        let text = """
Here is some **bold** text.
"""
        let layout = BrowserTextLayout(text)
        XCTAssertEqual(layout.paragraphs.count, 1)
        let paragraph = layout.paragraphs[0]
        XCTAssertEqual(paragraph.text, "Here is some bold text.")
        XCTAssertEqual(paragraph.highlights.count, 3)
        if (paragraph.highlights.count == 3) {
            let highlight1 = paragraph.highlights[0]
            let highlight2 = paragraph.highlights[1]
            let highlight3 = paragraph.highlights[2]
            XCTAssertEqual(highlight1.range.location, 0)
            XCTAssertEqual(highlight1.range.length, 13)
            XCTAssertEqual(highlight1.highlightTypes, [])
            XCTAssertEqual(highlight2.range.location, 13)
            XCTAssertEqual(highlight2.range.length, 4)
            XCTAssertEqual(highlight2.highlightTypes, [.bold])
            XCTAssertEqual(highlight3.range.location, 17)
            XCTAssertEqual(highlight3.range.length, 6)
            XCTAssertEqual(highlight3.highlightTypes, [])
        }
        XCTAssertEqual(paragraph.links.count, 0)
    }
    
    /// Create a paragraph with some italics text.
    func testSingleItalics() {
        let text = """
Here is some *italicised* text.
"""
        let layout = BrowserTextLayout(text)
        XCTAssertEqual(layout.paragraphs.count, 1)
        let paragraph = layout.paragraphs[0]
        XCTAssertEqual(paragraph.text, "Here is some italicised text.")
        XCTAssertEqual(paragraph.highlights.count, 3)
        if (paragraph.highlights.count == 3) {
            let highlight1 = paragraph.highlights[0]
            let highlight2 = paragraph.highlights[1]
            let highlight3 = paragraph.highlights[2]
            XCTAssertEqual(highlight1.range.location, 0)
            XCTAssertEqual(highlight1.range.length, 13)
            XCTAssertEqual(highlight1.highlightTypes, [])
            XCTAssertEqual(highlight2.range.location, 13)
            XCTAssertEqual(highlight2.range.length, 10)
            XCTAssertEqual(highlight2.highlightTypes, [.italics])
            XCTAssertEqual(highlight3.range.location, 23)
            XCTAssertEqual(highlight3.range.length, 6)
            XCTAssertEqual(highlight3.highlightTypes, [])
        }
        XCTAssertEqual(paragraph.links.count, 0)
    }
    
    /// Create a paragraph with some bold and some italics text.
    func testSeparateBoldAndItalics() {
        let text = """
Here is some *italicised* text. And here is some **bold** text. And a little more *italics*. One more **bold**.
"""
        let layout = BrowserTextLayout(text)
        XCTAssertEqual(layout.paragraphs.count, 1)
        let paragraph = layout.paragraphs[0]
        XCTAssertEqual(paragraph.text, "Here is some italicised text. And here is some bold text. And a little more italics. One more bold.")
        XCTAssertEqual(paragraph.highlights.count, 9)
        if (paragraph.highlights.count == 9) {
            let highlight1 = paragraph.highlights[0]
            let highlight2 = paragraph.highlights[1]
            let highlight3 = paragraph.highlights[2]
            let highlight4 = paragraph.highlights[3]
            let highlight5 = paragraph.highlights[4]
            let highlight6 = paragraph.highlights[5]
            let highlight7 = paragraph.highlights[6]
            let highlight8 = paragraph.highlights[7]
            let highlight9 = paragraph.highlights[8]
            XCTAssertEqual(highlight1.range.location, 0)
            XCTAssertEqual(highlight1.range.length, 13)
            XCTAssertEqual(highlight1.highlightTypes, [])
            XCTAssertEqual(highlight2.range.location, 13)
            XCTAssertEqual(highlight2.range.length, 10)
            XCTAssertEqual(highlight2.highlightTypes, [.italics])
            XCTAssertEqual(highlight3.range.location, 23)
            XCTAssertEqual(highlight3.range.length, 24)
            XCTAssertEqual(highlight3.highlightTypes, [])
            XCTAssertEqual(highlight4.range.location, 47)
            XCTAssertEqual(highlight4.range.length, 4)
            XCTAssertEqual(highlight4.highlightTypes, [.bold])
            XCTAssertEqual(highlight5.range.location, 51)
            XCTAssertEqual(highlight5.range.length, 25)
            XCTAssertEqual(highlight5.highlightTypes, [])
            XCTAssertEqual(highlight6.range.location, 76)
            XCTAssertEqual(highlight6.range.length, 7)
            XCTAssertEqual(highlight6.highlightTypes, [.italics])
            XCTAssertEqual(highlight7.range.location, 83)
            XCTAssertEqual(highlight7.range.length, 11)
            XCTAssertEqual(highlight7.highlightTypes, [])
            XCTAssertEqual(highlight8.range.location, 94)
            XCTAssertEqual(highlight8.range.length, 4)
            XCTAssertEqual(highlight8.highlightTypes, [.bold])
            XCTAssertEqual(highlight9.range.location, 98)
            XCTAssertEqual(highlight9.range.length, 1)
            XCTAssertEqual(highlight9.highlightTypes, [])
        }
        XCTAssertEqual(paragraph.links.count, 0)
    }
}

