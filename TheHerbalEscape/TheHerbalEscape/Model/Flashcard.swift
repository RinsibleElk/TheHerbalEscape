//
//  Flashcard.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 24/11/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import Foundation

/// A Flashcard can be used in the Flashcards section of the app and each side randomly placed against another.
/// - Text1 can be posed for Text2
/// - Text2 can be posed for Text1
/// - Image (if present), or Sound (if present) can be posed for Text1??
public protocol Flashcard : Codable {
    /// The answer. Usually matches the name of the entity.
    var FlashcardText1 : String { get }
    
    /// The question. Could be a foreign name, for instance in the case of a flower, it is the Latin name.
    var FlashcardText2 : String { get }
    
    /// Optional image to show to test for Text1.
    var FlashcardImage : String? { get }
    
    /// Optional sound to play to test for Text1.
    var FlashcardSound : String? { get }
}
