//
//  IContentRepository.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 27/11/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import Foundation

/// Repository with all the content in it.
protocol IContentRepository: class {
    var Browsables: [Browsable] { get }
    
    func fetchQuestion(question: String) -> Question
    
    func fetchContent(contentKey: ContentKey) -> Content
    
    func fetchCourse(courseName: String) -> Course
}
