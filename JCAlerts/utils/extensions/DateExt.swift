//
//  DateExt.swift
//  JCAlerts
//
//  Created by John Choi on 11/18/23.
//

import Foundation

extension Date {

    var year: Int? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        guard let y = Int(formatter.string(from: self)) else {
            return nil
        }
        return y
    }

    var month: Int? {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM"
        guard let m = Int(formatter.string(from: self)) else {
            return nil
        }
        return m
    }

    var day: Int? {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        guard let d = Int(formatter.string(from: self)) else {
            return nil
        }
        return d
    }
}
