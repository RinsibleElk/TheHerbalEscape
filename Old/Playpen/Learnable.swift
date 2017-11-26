//
//  Learnable.swift
//  Playpen
//
//  Created by Oliver Samson on 23/11/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import UIKit

class Learnable {
    var category : String
    var title : String
    var translation : String
    var image : UIImage
    var textPages : [String] = []
    init(category: String, title: String, translation:String, image:UIImage) {
        self.category = category
        self.title = title
        self.translation = translation
        self.image = image
    }
}
