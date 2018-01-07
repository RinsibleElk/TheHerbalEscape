//
//  DateExtensions.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 06/01/2018.
//  Copyright © 2018 Oliver Samson. All rights reserved.
//

import Foundation

extension Date {
    init(year: Int, month: Int, day: Int) {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        dateComponents.hour = 0
        dateComponents.minute = 0
        dateComponents.second = 0
        let calendar = Calendar.current
        let date = calendar.date(from: dateComponents)
        self.init(timeInterval: 0.0, since: date!)
    }
}
