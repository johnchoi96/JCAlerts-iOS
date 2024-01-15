//
//  CloudFirestoreDataTriggerService.swift
//  JCAlerts
//
//  Created by John Choi on 1/10/24.
//

import Foundation

class CloudFirestoreDataTriggerService {

    var delegate: CloudFirestoreDelegate?

    static var instance = CloudFirestoreDataTriggerService()

    var cloudFirestoreService = CloudFirestoreService()

    private init() {}

    func triggerDataRefresh() {
        delegate?.triggerDataRefresh()
        cloudFirestoreService.fetchNotificationPayloads()
    }
}
