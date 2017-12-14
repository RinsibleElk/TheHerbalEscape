//
//  FlashcardSide.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 14/12/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import UIKit

/// One side of a Flashcard, as presented to the user.
class FlashcardSide: Codable {
    // MARK: - Properties

    /// The colour to show for the top and bottom of the flashcard.
    var Color: CourseColor
    
    /// The global question. For the back side this will be nil.
    var Question: String?
    
    /// The text for this instance.
    var Text: String
    
    /// Optional image for this instance.
    var ImageName: String?
    
    /// Optional sound for this instance.
    var SoundName: String?
    
    // MARK: - Initializers
    init(color: CourseColor, question: String, text: String, imageName: String?, soundName: String?) {
        Color = color
        Question = question
        Text = text
        ImageName = imageName
        SoundName = soundName
    }
}
