//
//  ArrayExtensions.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 06/01/2018.
//  Copyright © 2018 Oliver Samson. All rights reserved.
//

import Foundation

extension Array where Element : Hashable {
    /// Get the distinct values in an array.
    func distinct() -> [Element] {
        return Array(Set(self))
    }
}

extension Array {
    /// Project each element onto another array and collect all results into a new array.
    func collect<T>(_ projection: (Element) -> [T]) -> [T] {
        var ts = [T]()
        for element in self {
            ts.append(contentsOf: projection(element))
        }
        return ts
    }
}
