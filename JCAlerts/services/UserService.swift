//
//  FirebaseService.swift
//  JCAlerts
//
//  Created by John Choi on 12/10/23.
//

import Foundation

class UserService {
    static let instance = UserService()

    private var currentUsername: String

    private init() {
        // check if UserDefaults has username defined
        let userDefaults = UserDefaults.standard
        if let username = userDefaults.string(forKey: "currentUsername") {
            currentUsername = username
        } else {
            // generate username
            let uuid = UUID().uuidString
            currentUsername = uuid
            userDefaults.setValue(uuid, forKey: "currentUsername")
        }
    }

    func getCurrentUsername() -> String {
        return currentUsername
    }
}
