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
    case Azure = "Azure"
    case Lavender = "Lavender"
    case MistyRose = "MistyRose"
    case LemonChiffon = "LemonChiffon"

    func getUiColor() -> UIColor {
        switch self {
        case .Azure:
            return Colors.Azure
        case .Lavender:
            return Colors.Lavender
        case .MistyRose:
            return Colors.MistyRose
        case .LemonChiffon:
            return Colors.LemonChiffon
        }
    }
}

