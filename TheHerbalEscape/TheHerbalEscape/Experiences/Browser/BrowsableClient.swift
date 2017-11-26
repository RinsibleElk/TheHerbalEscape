//
//  BrowsableClient.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 25/11/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import Foundation

/// Client for notifications about the selected browsable.
protocol BrowsableClient {
    func select(browsable: Browsable)
}
