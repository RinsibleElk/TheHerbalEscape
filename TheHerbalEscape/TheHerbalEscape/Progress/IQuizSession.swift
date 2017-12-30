//
//  IQuizSession.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 30/12/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import Foundation

/// Protocol for defining how to interact with quiz progress.
protocol IQuizSession {
    /// Whether there is anything to show.
    var hasMoreQuestionsToShow: Bool { get }

    /// Progress to the next question.
    
}
