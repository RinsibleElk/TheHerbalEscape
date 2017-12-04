//
//  BrowserContentElement.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 02/12/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import Foundation

/// Discriminated Union representing the elements comprising a single page of content.
enum BrowserContentElement {
    // MARK: - Cases
    case text(BrowserTextParagraph)
    case image(BrowserImage)
}
