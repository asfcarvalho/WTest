//
//  DateManager.swift
//  WTest
//
//  Created by Anderson F Carvalho on 16/09/21.
//

import UIKit

class DateManager {
    static func numberOfWeeksInMonth(_ date: Date) -> Int {
         var calendar = Calendar(identifier: .gregorian)
         calendar.firstWeekday = 1
        let week = calendar.component(.weekday, from: date)
        return week
    }
}
