//
//  IProgressFacade.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 06/01/2018.
//  Copyright © 2018 Oliver Samson. All rights reserved.
//

import Foundation

/// Facade for the progress object stored in CoreData. Aim is to help with testing without CoreData.
protocol IProgressFacade: class {
    var dueDate: Date { get set}
    var easyCount: Int16 { get set }
    var lastDifficulty: FlashcardDifficulty { get set }
    var name: String { get set }
    var question: String { get set }
}
