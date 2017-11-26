//
//  Flower.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 24/11/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import Foundation

/// Flower.
public final class Flower: Learnable, Flashcard, Browsable, Codable {
    // MARK: - Private properties
    private var commonName : String
    private var latinName : String
    private var image : String
    
    // MARK: - Initializers
    init(commonName: String, latinName: String, image: String, level: Double, pages:[BrowserPage]) {
        self.commonName = commonName
        self.latinName = latinName
        self.image = image
        self.Level = level
        self.BrowserPages = pages
        self.FlashcardSound = nil
    }
    
    // MARK: - Learnable
    /// The common name of this flower.
    public var Name: String {
        get {
            return commonName
        }
    }
    
    /// It's a flower.
    public var LearnableType: LearnableType = .flower
    
    public var Level: Double

    // MARK: - Flashcard
    /// The common name of this flower.
    public var FlashcardText1: String {
        get {
            return Name
        }
    }

    /// The Latin name of this flower.
    public var FlashcardText2: String {
        get {
            return latinName
        }
    }

    public var FlashcardImage: String? {
        get {
            return image
        }
    }
    
    public var FlashcardSound: String?
    
    // MARK: - Browsable
    public var BrowserTitle: String {
        get {
            return commonName
        }
    }
    
    public var BrowserImage: String {
        get {
            return image
        }
    }
    
    public var BrowserPages: [BrowserPage]
}
