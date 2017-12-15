//
//  ContentType.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 10/12/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import Foundation

/// All of the possible types of dynamic content.
enum ContentType: String, Codable {
    case Plant = "Plant"
    case HerbalAction = "HerbalAction"
    case HerbalFamily = "HerbalFamily"
}
