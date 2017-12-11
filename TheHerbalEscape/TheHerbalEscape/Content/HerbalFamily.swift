//
//  File.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 10/12/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import Foundation

/// Representation of a Herbal Family for use in tests, flashcards and displaying in the Browser.
class HerbalFamily : Browsable, Decodable {
    var Name: String
    var Level: Int
    var Introduction: String
    var ImageName: String
    var Sections: [BrowserContentMarkdownSection]
    var References: [String]

    // MARK: - Browsable
    var BrowsableTitle: String
    var BrowsableImage: String
    var BrowsableSections: [BrowserContentSection] {
        get {
            var contents = [BrowserContentSection]()
            
            // First section is the title, the latin name and the image.
            var mainElements = [BrowserContentElement]()
            mainElements.append(.image(BrowserImage(ImageName, "Photograph of \(Name)")))
            mainElements.append(.text(BrowserTextParagraph(Introduction)))
            
            // Extra custom sections.
            for section in Sections {
                let layout = BrowserTextLayout(section.Content)
                let customSection = BrowserContentSection(title: section.Title, isCollapsible: true, elements: layout.paragraphs.map({ (paragraph) -> BrowserContentElement in
                    return .text(paragraph)
                }))
                contents.append(customSection)
            }
            
            // References.
            var referencesText = ""
            for reference in References {
                referencesText += "\n- \(reference)"
            }
            let referencesSection = BrowserContentSection(title: "References", isCollapsible: true, elements: [.text(BrowserTextParagraph(referencesText))])
            contents.append(referencesSection)
            
            return contents
        }
    }
}


