//
//  EmptyBrowsable.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 03/12/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import Foundation

class EmptyBrowsable: Browsable {
    // MARK: - Browsable
    var BrowsableTitle: String { get { return "Not found" } }
    var BrowsableImage: String { get { return "noImage" } }
    var BrowsableSections: [BrowserContentSection] { get { return [] } }
}
