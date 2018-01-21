//
//  OverallProgressSummary.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 31/12/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import Foundation

/// All progress summarised.
class OverallProgressSummary: Codable {
    // MARK: - Constants
    static let AllCourses = Course(name: "All", color: CourseColor.White, level: 1)
    
    // MARK: - Properties
    /// Summary of total progress across all courses.
    var TotalProgress: ProgressSummary
    
    /// Per-course progress summary.
    var PerCourseSummary: [String:ProgressSummary]
    
    /// Courses.
    var Courses: [Course]
    
    // MARK: - Initializers
    init() {
        TotalProgress = ProgressSummary(course: nil)
        PerCourseSummary = [String:ProgressSummary]()
        Courses = [OverallProgressSummary.AllCourses]
    }
    
    // MARK: - API
    /// Get the progress for a course.
    func getProgress(course: Course?) -> ProgressSummary {
        if course == nil || course!.Name == OverallProgressSummary.AllCourses.Name {
            return TotalProgress
        }
        else {
            let progress = PerCourseSummary[course!.Name]
            if progress == nil {
                let perCourseProgress = ProgressSummary(course: course!.Name)
                PerCourseSummary[course!.Name] = perCourseProgress
                Courses.append(course!)
                return perCourseProgress
            }
            else {
                return progress!
            }
        }
    }
    
    /// Update the difficulty of a flashcard or question.
    func update(course:Course, oldValue: FlashcardDifficulty?, newValue: FlashcardDifficulty) {
        getProgress(course: nil).update(oldValue: oldValue, newValue: newValue)
        getProgress(course: course).update(oldValue: oldValue, newValue: newValue)
    }
}
