//
//  DateExt.swift
//  JCAlerts
//
//  Created by John Choi on 11/18/23.
//

import Foundation

extension Date {

    /**
     Returns human readable date.
     For example: January 1, 1970
     */
    var formattedDate: String {
        "\(StringUtil.getStringMonth(month: self.month) ?? "N/A") \(self.day), \(self.year)"
    }

    var year: Int {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        formatter.locale = .current
        formatter.timeZone = .current
        guard let y = Int(formatter.string(from: self)) else {
            return 1970
        }
        return y
    }

    var month: Int {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM"
        formatter.locale = .current
        formatter.timeZone = .current
        guard let m = Int(formatter.string(from: self)) else {
            return 1
        }
        return m
    }

    var day: Int {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        formatter.locale = .current
        formatter.timeZone = .current
        guard let d = Int(formatter.string(from: self)) else {
            return 1
        }
        return d
    }

    var get12FormatHour: Int {
        var result = self.get24FormatHour
        if result == 0 {
            result = 12
        } else if result > 12 {
            result -= 12
        }
        return result
    }

    var get24FormatHour: Int {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH"
        formatter.locale = .current
        formatter.timeZone = .current
        guard let h = Int(formatter.string(from: self)) else {
            return 1
        }
        return h
    }

    var minute: Int {
        let formatter = DateFormatter()
        formatter.dateFormat = "mm"
        formatter.locale = .current
        formatter.timeZone = .current
        guard let m = Int(formatter.string(from: self)) else {
            return 1
        }
        return m
    }

    /**
     Returns either "AM" or "PM"
     */
    var isAm: String {
        let rawHour = self.get24FormatHour
        if rawHour >= 0 && rawHour < 12 {
            return "AM"
        }
        return "PM"
    }

    static var epochDate: Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter.date(from: "1970/01/01")!
    }
}
