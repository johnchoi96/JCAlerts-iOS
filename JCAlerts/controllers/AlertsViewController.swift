//
//  ViewController.swift
//  JCAlerts
//
//  Created by John Choi on 10/7/23.
//

import UIKit
import FirebaseMessaging

class AlertsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.Segues.alertsToNotificationDisplay {
            let vc = segue.destination as! NotificationDisplayViewController
            vc.payload = sender as? [AnyHashable: Any]
            present(vc, animated: true)
        }
    }

}
