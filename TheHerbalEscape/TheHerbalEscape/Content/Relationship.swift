//
//  Relationship.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 09/12/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import Foundation

/// Represents a relationship between one to two entities.
class Relationship: Codable {
    /// The unique name of this relationship.
    var Name: String

    /// The class name of the type that has the field on it, e.g. "Plant".
    var BaseEntity: String

    /// The name of the field on the BaseEntity.
    var FieldName: String

    /// The type of the relationship.
    /// Options are: Simple, ManyToOne, ManyToMany
    var RelationshipType: RelationshipType

    /// The class name of the type that is referenced.
    /// This can be String, Image, or another entity.
    var TargetEntity: String

    /// The simple field name of the target entity.
    /// If TargetEntity is String or Image, this is empty.
    /// Otherwise, this is the name field on the target entity.
    var TargetFieldName: String
}
