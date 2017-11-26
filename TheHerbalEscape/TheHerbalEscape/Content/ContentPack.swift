//
//  ContentPack.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 24/11/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import Foundation

/// Content data that we'll somehow need to get into the application.
/// TODO: Define a package for content?
public protocol ContentPack {
    /// The name of the content pack.
    var Name : String { get }
    
    /// The data.
    var Learnables : [Learnable] { get }
}
