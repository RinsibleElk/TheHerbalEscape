//
//  FakeProgressKey.swift
//  TheHerbalEscapeTests
//
//  Created by Oliver Samson on 06/01/2018.
//  Copyright © 2018 Oliver Samson. All rights reserved.
//

import Foundation
import XCTest
@testable import TheHerbalEscape

struct FakeProgressKey: ProgressKey, Hashable {
    var hashValue: Int {
        get {
            return question.hashValue ^ name.hashValue
        }
    }
    
    static func ==(lhs: FakeProgressKey, rhs: FakeProgressKey) -> Bool {
        return lhs.question == rhs.question && lhs.name == rhs.name
    }
    
    var question: String
    
    var name: String
    
    init(question: String, name: String) {
        self.question = question
        self.name = name
    }
}
