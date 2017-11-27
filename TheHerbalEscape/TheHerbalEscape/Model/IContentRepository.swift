//
//  IContentRepository.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 27/11/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import Foundation

/// Repository with all the content in it.
public protocol IContentRepository: class {
    var Flowers: [Flower] { get }
    var Browsables: [Browsable] { get }
}
