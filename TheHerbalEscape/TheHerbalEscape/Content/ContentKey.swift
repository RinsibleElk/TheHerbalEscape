//
//  ContentKey.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 14/12/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import Foundation

struct ContentKey: Hashable {
    var hashValue: Int {
        get {
            return ContentType.hashValue ^ ContentName.hashValue
        }
    }
    
    static func ==(lhs: ContentKey, rhs: ContentKey) -> Bool {
        return lhs.ContentType == rhs.ContentType && lhs.ContentName == rhs.ContentName
    }
    
    var ContentType: ContentType
    var ContentName: String
    init(contentType: ContentType, contentName: String) {
        ContentType = contentType
        ContentName = contentName
    }
}
