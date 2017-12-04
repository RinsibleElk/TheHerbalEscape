//
//  Browsable.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 24/11/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import Foundation

/// A type that can be displayed in the browser.
protocol Browsable {
    /// The title for the browsable.
    var BrowsableTitle : String { get }
    
    /// The image for the browsable.
    var BrowsableImage : String { get }
    
    // TODO More stuff? Level? Type? Could get some colorization?
    
    /// The browsable sections.
    var BrowsableSections : [BrowserContentSection] { get }
}
