//
//  CloudFirestoreDataTriggerService.swift
//  JCAlerts
//
//  Created by John Choi on 1/10/24.
//

import Foundation

class CloudFirestoreDataTriggerService {

    static var instance = CloudFirestoreDataTriggerService()

    var cloudFirestoreService = CloudFirestoreService()

    private init() {}

    func triggerDataRefresh() {
        cloudFirestoreService.fetchNotificationPayloads()
    }
}
