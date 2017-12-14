//
//  Plant.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 01/12/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import Foundation

/// Representation of a Plant for use in Quizzes, Flashcards and displaying in the Browser.
class Plant : Browsable, Content, Decodable {
    // MARK: - Properties
    var CommonName: String
    var LatinName: String
    var ImageName: String
    var Introduction: String?
    var Level: Int
    var HerbalFamily: String
    var PartsUsed: [String]
    var Regions: [String]
    var Actions: [String]
    var Constituents: [String]
    var TreatsInfusion: [String]
    var TreatsOintment: [String]
    var Habitat: [String]
    var Sections: [BrowserContentMarkdownSection]
    var References: [String]

    // MARK: - Browsable
    var BrowsableTitle : String {
        get {
            return CommonName
        }
    }
    var BrowsableImage : String {
        get {
            return ImageName
        }
    }
    var BrowsableSections: [BrowserContentSection] {
        get {
            var contents = [BrowserContentSection]()
            
            // First section is the title, the latin name and the image.
            var mainElements = [BrowserContentElement]()
            mainElements.append(.text(BrowserTextParagraph("**Latin name:** \(LatinName)")))
            mainElements.append(.image(BrowserImage(ImageName, "Photograph of \(CommonName)")))
            if (Introduction != nil) {
                mainElements.append(.text(BrowserTextParagraph(Introduction!)))
            }
            
            // Autogenerated content for some of the main attributes.
            var actionsText = "**Actions:**"
            for action in Actions {
                actionsText += "\n- [\(action)]()"
            }
            mainElements.append(.text(BrowserTextParagraph(actionsText)))
            var constituentsText = "**Constituents:**"
            for constituent in Constituents {
                constituentsText += "\n- [\(constituent)]()"
            }
            mainElements.append(.text(BrowserTextParagraph(constituentsText)))

            let mainSection = BrowserContentSection(title: CommonName, isCollapsible: false, elements: mainElements)
            contents.append(mainSection)
            
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
    
    // MARK: - Content
    func getValue(name: String) -> String? {
        switch name {
        case "CommonName":
            return CommonName
        case "LatinName":
            return LatinName
        case "ImageName":
            return ImageName
        case "HerbalFamily":
            return HerbalFamily
        default:
            return nil
        }
    }
    
    func getValues(name: String) -> [String] {
        switch name {
        case "Actions":
            return Actions
        case "Constituents":
            return Constituents
        default:
            return [String]()
        }
    }
}

public class PlantContents : Decodable {
    var Plants: [Plant]
    static func decodeFromJSON(jsonData: Data) -> [Plant] {
        let jsonDecoder = JSONDecoder()
        do {
            let plants = try jsonDecoder.decode(PlantContents.self, from: jsonData)
            return plants.Plants
        }
        catch {
            return []
        }
    }
}

