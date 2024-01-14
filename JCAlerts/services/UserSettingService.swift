//
//  FirebaseService.swift
//  JCAlerts
//
//  Created by John Choi on 12/10/23.
//

import Foundation

class UserSettingService {
    static let instance = UserSettingService()

    let userDefaults = UserDefaults.standard

    private var currentUsername: String

    private var textViewFontSize: Int

    private var firstTimeRunning: Bool

    var isDebugMode: Bool {
        #if DEBUG
        true
        #else
        false
        #endif
    }

    private init() {
        // check if UserDefaults has username defined
        if let username = userDefaults.string(forKey: "currentUsername") {
            currentUsername = username
        } else {
            // generate username
            let uuid = UUID().uuidString
            currentUsername = uuid
            userDefaults.setValue(uuid, forKey: "currentUsername")
        }

        // check if UserDefaults has textViewFontSize defined
        if userDefaults.integer(forKey: "textViewFontSize") != 0 {
            textViewFontSize = userDefaults.integer(forKey: "textViewFontSize")
        } else {
            textViewFontSize = 14
            userDefaults.setValue(textViewFontSize, forKey: "textViewFontSize")
        }

        if let firstTime = userDefaults.string(forKey: "firstTimeRunning") {
            firstTimeRunning = Bool(firstTime)!
        } else {
            firstTimeRunning = true
        }
    }

    func getFirstTimeRunning() -> Bool {
        return firstTimeRunning
    }

    func setFirstTimeRunningToFalse() {
        firstTimeRunning = false
        userDefaults.set("false", forKey: "firstTimeRunning")
    }

    func getTextViewFontSize() -> Int {
        return textViewFontSize
    }

    func decreaseTextViewFontSize() {
        if textViewFontSize <= 12 {
            return
        }
        textViewFontSize -= 1
        userDefaults.setValue(textViewFontSize, forKey: "textViewFontSize")
    }

    func increaseTextViewFontSize() {
        if textViewFontSize >= 30 {
            return
        }
        textViewFontSize += 1
        userDefaults.setValue(textViewFontSize, forKey: "textViewFontSize")
    }

    func getCurrentUsername() -> String {
        return currentUsername
    }
}
