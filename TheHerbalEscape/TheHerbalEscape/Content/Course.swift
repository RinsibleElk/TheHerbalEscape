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
}
