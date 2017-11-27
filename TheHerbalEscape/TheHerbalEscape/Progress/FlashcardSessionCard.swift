//
//  FlashcardSessionCard.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 27/11/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import Foundation

/// One of a chosen set of cards for a flashcard session.
public struct FlashcardSessionCard : Codable {
    // MARK: - Private properties
    private var frontSide : FlashcardSessionCardSide
    private var backSide : FlashcardSessionCardSide
    
    // MARK: - Initializers
    init(_ frontSide: FlashcardSessionCardSide, _ backSide: FlashcardSessionCardSide) {
        self.frontSide = frontSide
        self.backSide = backSide
    }
    
    // MARK: - Properties
    
    /// The front side - the test side.
    public var FrontSide: FlashcardSessionCardSide {
        get {
            return frontSide
        }
    }
    
    /// The back side - the answer side.
    public var BackSide: FlashcardSessionCardSide {
        get {
            return backSide
        }
    }
}
