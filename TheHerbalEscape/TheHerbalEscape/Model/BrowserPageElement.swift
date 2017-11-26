//
//  PageElement.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 25/11/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import Foundation

/// Discriminated Union representing the elements comprising a single page of content.
public enum BrowserPageElement: Codable {
    // MARK: - Codable
    public init(from decoder: Decoder) throws {
        self = try BrowserPageElement.Coding.init(from: decoder).element()
    }
    
    public func encode(to encoder: Encoder) throws {
        try BrowserPageElement.Coding.init(pageElement: self).encode(to: encoder)
    }
    
    fileprivate struct Coding: Codable {
        private var heading : BrowserPageHeading?
        private var text : BrowserPageText?
        private var image : BrowserPageImage?
        private var etymology : BrowserPageEtymology?
        fileprivate init(pageElement: BrowserPageElement) {
            switch pageElement {
            case .heading(let heading):
                self.heading = heading
            case .text(let text):
                self.text = text
            case .image(let image):
                self.image = image
            case .etymology(let etymology):
                self.etymology = etymology
            }
        }
        fileprivate func element() throws -> BrowserPageElement {
            switch (heading, text, image, etymology) {
            case (.some(let heading), nil, nil, nil):
                return BrowserPageElement.heading(heading)
            case (nil, .some(let text), nil, nil):
                return BrowserPageElement.text(text)
            case (nil, nil, .some(let image), nil):
                return BrowserPageElement.image(image)
            case (nil, nil, nil, .some(let etymology)):
                return BrowserPageElement.etymology(etymology)
            default:
                throw CodingError.pageElementError
            }
        }
    }
    
    // MARK: - Cases
    case heading(BrowserPageHeading)
    case text(BrowserPageText)
    case image(BrowserPageImage)
    case etymology(BrowserPageEtymology)
}
