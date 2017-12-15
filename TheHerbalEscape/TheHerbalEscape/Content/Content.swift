//
//  Content.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 14/12/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import Foundation

/// Queryable content type, to save on reflection, which I presume is expensive and pointless at this stage.
protocol Content {
    /// Get a value for a simple field.
    func getValue(name: String) -> String?

    /// Get a value for an array field.
    func getValues(name: String) -> [String]
    
    /// The key for this content for lookups.
    var contentKey: ContentKey { get }
}
