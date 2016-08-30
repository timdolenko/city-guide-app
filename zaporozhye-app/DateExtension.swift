//
//  DateExtension.swift
//  zaporozhye-app
//
//  Created by Timofey Dolenko on 8/30/16.
//  Copyright © 2016 Timofey Dolenko. All rights reserved.
//

import Foundation

extension Date {
    
    func dateAt(hours: Int, minutes: Int) -> Date {
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        var dateComponents = DateComponents()
        dateComponents.hour = hours
        dateComponents.minute = minutes
        dateComponents.second = 0
        let newDate = calendar.date(from: dateComponents)
        return newDate!
    }
    
}
