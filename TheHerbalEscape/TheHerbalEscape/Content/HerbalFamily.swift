//
//  File.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 10/12/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import Foundation

/// Representation of a Herbal Family for use in tests, flashcards and displaying in the Browser.
class HerbalFamily : Browsable, Content, Decodable {
    // MARK: - Properties
    var Name: String
    var Introduction: String?
    var ImageName: String

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
            
            // First section is the title, the latin name and the image.
            var mainElements = [BrowserContentElement]()
            mainElements.append(.image(BrowserImage(ImageName, "Photograph of \(Name)")))
            if (Introduction != nil) {
                mainElements.append(.text(BrowserTextParagraph(Introduction!)))
            }
            contents.append(BrowserContentSection(title: Name, isCollapsible: false, elements: mainElements))
            
            return contents
        }
    }
    
    // MARK: - Content
    func getValue(name: String) -> String? {
        switch name {
        case "Name": return Name
        case "ImageName": return ImageName
        default:
            return nil
        }
    }
    
    func getValues(name: String) -> [String] {
        switch name {
        default:
            return [String]()
        }
    }
}

public class HerbalFamilyContents : Decodable {
    var Families: [HerbalFamily]
    static func decodeFromJSON(jsonData: Data) -> [HerbalFamily] {
        let jsonDecoder = JSONDecoder()
        do {
            let herbalFamilies = try jsonDecoder.decode(HerbalFamilyContents.self, from: jsonData)
            return herbalFamilies.Families
        }
        catch {
            return []
        }
    }
}


