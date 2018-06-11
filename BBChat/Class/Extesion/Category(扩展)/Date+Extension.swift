//
//  Date+Extension.swift
//  BBChat
//
//  Created by bb on 2018/5/30.
//  Copyright © 2018年 bb. All rights reserved.
//

import UIKit

extension Date {

    static var systemDate: Date {
        let date = Date()
        let zone = NSTimeZone.system
        let interval = zone.secondsFromGMT(for: date)
        return date.addingTimeInterval(TimeInterval(interval))
    }

    static func getDaysBetweenDates(formDate: Date, toDate: Date) -> Int {
        let interval = toDate.timeIntervalSince(formDate)
        return Int(interval) / 86400
    }
    
}
