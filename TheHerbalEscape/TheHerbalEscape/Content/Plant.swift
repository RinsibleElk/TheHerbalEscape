//
//  Plant.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 01/12/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import Foundation

/// Representation of a Plant for use in Quizzes, Flashcards and displaying in the Browser.
public class Plant : Browsable, Decodable {
    // MARK: - Properties
    var CommonName: String
    var LatinName: String
    var ImageName: String
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
            mainElements.append(.text(BrowserTextParagraph(LatinName)))
            mainElements.append(.image(BrowserImage(ImageName, "Photograph of \(LatinName)")))
            let mainSection = BrowserContentSection(title: CommonName, isCollapsible: false, elements: mainElements)
            contents.append(mainSection)
            
            return contents
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

public final class DataManager {
    public static func urlForResource(_ bundleName: String, _ resourceName: String, _ resourceExtension: String) -> URL {
        let bundlePath = Bundle.main.path(forResource: bundleName, ofType: "bundle")
        let bundle = Bundle(path: bundlePath!)
        let resourceUrl = bundle?.url(forResource: resourceName, withExtension: resourceExtension)
        return resourceUrl!
    }

    public static func getContents(_ resourceUrl: URL, completion:@escaping (_ data:Data?, _ error:Error?) -> Void) {
        DispatchQueue.global(qos: .background).async {
            let data = try! Data(contentsOf: resourceUrl, options: .uncached)
            completion(data, nil)
        }
    }
}
