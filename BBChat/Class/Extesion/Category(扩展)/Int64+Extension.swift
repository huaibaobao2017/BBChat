//
//  Int+Extension.swift
//  BBChat
//
//  Created by bb on 2017/12/25.
//  Copyright © 2017年 bb. All rights reserved.
//

import Foundation

extension Int64 {
    
    var currentTimeInterval: TimeInterval {
        return NSDate().timeIntervalSince1970
    }
    
    //MARK: 根据规则返回对应的字符串
    func getTimeString() -> String {
        if isToday {
            return "\(self.yesterdayTimeStr())"
        } else if isYesterday {
            return "昨天 \(self.yesterdayTimeStr())"
        } else if isYear {
            return noYesterdayTimeStr()
        } else {
            return yearTimeStr()
        }
    }
    
    private var selfDate: Date {
        return Date(timeIntervalSince1970: TimeInterval(self))
    }
    
    /// 距当前有几分钟
    var minute: Int {
        let dateComponent = Calendar.current.dateComponents([.minute], from: selfDate, to: Date())
        return dateComponent.minute!
    }
    
    /// 距当前有几小时
    var hour: Int {
        let dateComponent = Calendar.current.dateComponents([.hour], from: selfDate, to: Date())
        return dateComponent.hour!
    }
    
    /// 是否是今天
    var isToday: Bool {
        return Calendar.current.isDateInToday(selfDate)
    }
    
    /// 是否是昨天
    var isYesterday: Bool {
        return Calendar.current.isDateInYesterday(selfDate)
    }
    
    /// 是否是今年
    var isYear: Bool {
        let nowComponent = Calendar.current.dateComponents([.year], from: Date())
        let component = Calendar.current.dateComponents([.year], from: selfDate)
        return (nowComponent.year == component.year)
    }
    
    func yesterdayTimeStr() -> String {
        let format = DateFormatter()
        format.dateFormat = "HH:mm"
        return format.string(from: selfDate)
    }
    
    func noYesterdayTimeStr() -> String {
        let format = DateFormatter()
        format.dateFormat = "MM-dd HH:mm"
        return format.string(from: selfDate)
    }
    
    func yearTimeStr() -> String {
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm"
        return format.string(from: selfDate)
    }
}
