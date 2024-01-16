//
//  FirstTimeWelcomeTip.swift
//  JCAlerts
//
//  Created by John Choi on 1/16/24.
//

import Foundation
import TipKit

struct FirstTimeWelcomeTip: Tip {

    private let WELCOME_MSG = "Welcome to JCAlerts!"
    private let WELCOME_MSG_BODY = """
For the first time setup, please go to the Settings tab and configure notification subscriptions
"""

    var title: Text {
        Text(WELCOME_MSG)
    }

    var message: Text? {
        Text(WELCOME_MSG_BODY)
    }

    var image: Image? {
        Image(systemName: "hand.wave.fill")
    }

    var actions: [Action] {
        Action {
            invalidate(reason: .tipClosed)
        } _: {
            Text("Don't Show Again")
        }
    }
}
