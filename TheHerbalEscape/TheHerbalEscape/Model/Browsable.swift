//
//  Browsable.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 24/11/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import Foundation

/// A type that can be displayed in the browser.
public protocol Browsable : Codable {
    /// The title for the browsable.
    var BrowserTitle : String { get }
    
    /// The image for the browsable.
    var BrowserImage : String { get }
    
    /// The browsable pages - defined in custom markdown, but preprocessed to be stored in an efficient format.
    var BrowserPages : [BrowserPage] { get }
}

/// An empty browsable.
public class EmptyBrowsable : Browsable {
    public var BrowserTitle: String = "Not found"
    public var BrowserImage: String = "noImage"
    public var BrowserPages: [BrowserPage] = []
}
