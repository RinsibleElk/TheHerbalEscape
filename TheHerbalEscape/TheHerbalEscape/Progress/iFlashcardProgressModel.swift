//
//  iFlashcardProgressModel.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 27/11/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import Foundation

/// Progress model for flashcards.
public protocol IFlashcardProgressModel: class {
    /// The easy count - this is the number of consecutive times this flashcard has been found easy or very easy.
    /// (I think I saw some research somewhere that you should see something up to 8 times, maybe 12, then bin it.
    /// We could just keep the raw count of views here, and bin the card after that point.)
    /// The aim here is to decide how well the user knows their content, for displaying a global progress.
    var easyCount : Int16 { get set }
    
    /// The next date to show this card.
    var nextDate : Date { get set }
    
    /// Reset the flashcard progress back to its original state.
    func resetToOriginalState()
}
