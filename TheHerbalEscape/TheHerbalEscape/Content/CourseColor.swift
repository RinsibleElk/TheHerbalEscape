//
//  CourseColor.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 10/12/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import UIKit

/// Colours representing Courses within the app.
enum CourseColor: String, Codable {
    case Yellow = "Yellow"
    case Pink = "Pink"
    case Brown = "Brown"
    case Blue = "Blue"
    case Orange = "Orange"
    case Purple = "Purple"
    
    func getUiColor() -> UIColor {
        switch self {
        case .Yellow:
            return Colors.Yellow
        case .Pink:
            return Colors.Pink
        case .Brown:
            return Colors.Brown
        case .Blue:
            return Colors.Blue
        case .Orange:
            return Colors.Orange
        case .Purple:
            return Colors.Purple
        }
    }
}

