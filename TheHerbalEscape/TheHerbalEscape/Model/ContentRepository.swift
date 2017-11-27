//
//  ContentRepository.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 25/11/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import Foundation

/// Repository with all the content in it.
/// Very eager for the minute. Meh.
class ContentRepository: IContentRepository {
    var Flowers: [Flower] = []
    var Browsables: [Browsable] = []
    
    /// Just load in a content pack from the outside. Will probably do this from the AppDelegate for now.
    func loadContentPack(contentPack: ContentPack) {
        for learnable in contentPack.Learnables {
            if let flower = learnable as? Flower {
                Flowers.append(flower)
            }
            if let browsable = learnable as? Browsable {
                Browsables.append(browsable)
            }
        }
    }
}
