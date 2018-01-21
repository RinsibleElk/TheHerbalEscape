//
//  Course.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 09/12/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import Foundation

/// A Course is a module that can be tested in the app.
class Course: Codable {
    /// Each Course has a predefined named colour that is used as a visual cue throughout the app.
    /// Options are: Yellow, Pink, Brown, Blue, Orange, Purple
    var Color: CourseColor
    
    /// The name of the course. Used in navigation.
    var Name: String
    
    /// The level of the Course. Used to determine if the Course is applicable for testing based on the user's preferences.
    var Level: Int
    
    // MARK: - Initializers
    init(name: String, color: CourseColor, level: Int) {
        Name = name
        Color = color
        Level = level
    }
}

public class CourseContents : Decodable {
    var Courses: [Course]
    static func decodeFromJSON(jsonData: Data) -> [Course] {
        let jsonDecoder = JSONDecoder()
        do {
            let courses = try jsonDecoder.decode(CourseContents.self, from: jsonData)
            return courses.Courses
        }
        catch {
            return []
        }
    }
}

