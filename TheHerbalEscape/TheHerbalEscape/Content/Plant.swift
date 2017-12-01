//
//  Plant.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 01/12/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import Foundation

/// Representation of a Plant for use in Quizzes, Flashcards and displaying in the Browser.
public class PlantContent : Decodable {
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
    var Sections: [BrowserContentSection]
    var References: [String]
}

public class PlantContents : Decodable {
    var Plants: [PlantContent]
    static func decodeFromJSON(jsonData: Data) -> [PlantContent] {
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
    public static func getJSONFromURL(_ resource:String, completion:@escaping (_ data:Data?, _ error:Error?) -> Void) {
        DispatchQueue.global(qos: .background).async {
            let filePath = Bundle.main.path(forResource: resource, ofType: "json")
            let url = URL(fileURLWithPath: filePath!)
            // TODO - handle errors
            let data = try! Data(contentsOf: url, options: .uncached)
            completion(data, nil)
        }
    }
}
