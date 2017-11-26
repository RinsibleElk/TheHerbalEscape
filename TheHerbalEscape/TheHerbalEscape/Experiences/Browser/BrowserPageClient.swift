//
//  BrowserPageClient.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 26/11/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import Foundation

/// Defines a page that can receive a BrowserPage.
protocol BrowserPageClient {
    func setBrowserPage(browserPage: BrowserPage)
}
