//
//  Action.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 11/12/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import Foundation

/// Representation of a HerbalAction for use in Quizzes, Flashcards and displaying in the Browser.
class HerbalAction : Browsable, Decodable {
    // MARK: - Browsable
    var BrowsableTitle: String {
        get {
            return Name
        }
    }
    var BrowsableImage: String {
        get {
            return ImageName
        }
    }
    var BrowsableSections: [BrowserContentSection] {
        get {
            var contents = [BrowserContentSection]()
            
            // Main elements
            var mainElements = [BrowserContentElement]()
            mainElements.append(.image(BrowserImage(ImageName, "A pictoral representation of the effect of the \(Name) herbal action")))
            let mainSection = BrowserContentSection(title: Name, isCollapsible: false, elements: mainElements)
            contents.append(mainSection)

            return contents
        }
    }

    // MARK: - Properties
    var Name: String
    var ImageName: String
}

public class HerbalActionContents : Decodable {
    var Actions: [HerbalAction]
    static func decodeFromJSON(jsonData: Data) -> [HerbalAction] {
        let jsonDecoder = JSONDecoder()
        do {
            let herbalActions = try jsonDecoder.decode(HerbalActionContents.self, from: jsonData)
            return herbalActions.Actions
        }
        catch {
            return []
        }
    }
}
