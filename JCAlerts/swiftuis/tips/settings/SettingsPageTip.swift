//
//  NotificationCategoryTip.swift
//  JCAlerts
//
//  Created by John Choi on 1/16/24.
//

import Foundation
import TipKit

struct NotificationCategoryTip: Tip {

    private let MSG = "You can set your notification preferences here."

    var title: Text {
        Text(MSG)
    }

    var image: Image? {
        Image(systemName: "hand.tap.fill")
    }

    var actions: [Action] {
        Action {
            invalidate(reason: .tipClosed)
        } _: {
            Text("Don't Show Again")
        }
    }
}
