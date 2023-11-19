//
//  StringUtil.swift
//  JCAlerts
//
//  Created by John Choi on 11/18/23.
//

import Foundation

struct StringUtil {

    static func getStringMonth(month: Int) -> String? {
        if month < 1 || month > 12 {
            return nil
        }
        var monthStr: String
        switch month {
        case 1:
            monthStr = "January"
        case 2:
            monthStr = "February"
        case 3:
            monthStr = "March"
        case 4:
            monthStr = "April"
        case 5:
            monthStr = "May"
        case 6:
            monthStr = "June"
        case 7:
            monthStr = "July"
        case 8:
            monthStr = "August"
        case 9:
            monthStr = "September"
        case 10:
            monthStr = "October"
        case 11:
            monthStr = "November"
        case 12:
            monthStr = "December"
        default:
            fatalError("Should not get here")
        }
        return monthStr
    }
}
