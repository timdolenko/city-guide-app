//
//  DateExtension.swift
//  zaporozhye-app
//
//  Created by Timofey Dolenko on 8/30/16.
//  Copyright © 2016 Timofey Dolenko. All rights reserved.
//

import Foundation

extension Date {
    
    private static func timeAsIntegerFrom(date: Date) -> Int {
        var currentCal = NSCalendar.current
        currentCal.timeZone = NSTimeZone.local
        let comps: DateComponents = currentCal.dateComponents([Calendar.Component.hour, Calendar.Component.minute], from: date)
        return comps.hour! * 100 + comps.minute!
    }
    
    static func timeIsBetween(startHour: Int, endHour: Int) -> Bool {
        let startTime = startHour * 100
        let endTime = endHour * 100
        let nowTime = Date.timeAsIntegerFrom(date: Date())
        
        if startTime == endTime { return false }
        
        if startTime < endTime {
            if nowTime >= startTime {
                if nowTime < endTime { return true }
            }
            return false
        } else {
            if nowTime >= startTime || nowTime < endTime {
                return true
            }
            return false
        }
    }
    
}
