//
//  FakeProgressFacade.swift
//  TheHerbalEscapeTests
//
//  Created by Oliver Samson on 06/01/2018.
//  Copyright © 2018 Oliver Samson. All rights reserved.
//

import Foundation
import XCTest
@testable import TheHerbalEscape

class FakeProgressFacade: IProgressFacade {
    var dueDate: Date
    
    var easyCount: Int16
    
    var lastDifficulty: FlashcardDifficulty
    
    var name: String
    
    var question: String
    
    init(dueDate: Date, easyCount: Int16, lastDifficulty: FlashcardDifficulty, name: String, question: String) {
        self.dueDate = dueDate
        self.easyCount = easyCount
        self.lastDifficulty = lastDifficulty
        self.name = name
        self.question = question
    }
}
