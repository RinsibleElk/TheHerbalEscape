//
//  RelationshipType.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 09/12/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import Foundation

/// Types of relationship that can be tested within the app.
enum RelationshipType: String, Codable {
    /// This is a simple one-to-one property like for example each Plant has a unique LatinName.
    case Simple = "Simple"
    /// This is a relationship where for example multiple Plants can have the same single value for Herbal Family.
    case ManyToOne = "ManyToOne"
    /// This is a relationship where for example multiple Plants can have several Actions each, which overlap.
    case ManyToMany = "ManyToMany"
}
