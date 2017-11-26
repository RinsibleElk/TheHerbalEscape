//
//  BrowserPageImage.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 25/11/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import Foundation

/// Representation of an image that can be got from the bundle assets.
public class BrowserPageImage: Codable {
    var ImageName : String
    var ImageDescription : String
    init(imageName: String, imageDescription: String) {
        ImageName = imageName
        ImageDescription = imageDescription
    }
}
