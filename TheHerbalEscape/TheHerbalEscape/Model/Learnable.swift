//
//  Learnable.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 24/11/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import Foundation

/// A Learnable is any piece of content within the application.
public protocol Learnable : Codable {
    /// Unique name.
    var Name : String { get }

    /// The type of this learnable.
    var LearnableType : LearnableType { get }
    
    /// The level of this learnable.
    var Level : Double { get }
}
