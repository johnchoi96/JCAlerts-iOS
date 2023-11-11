//
//  NotificationDisplayViewController.swift
//  JCAlerts
//
//  Created by John Choi on 11/11/23.
//

import UIKit

class NotificationDisplayViewController: UIViewController {

    static let nib = UINib(nibName: "NotificationDisplayViewController", bundle: nil)
    static let identifier = K.Nibs.Views.notificationDisplayView

    @IBOutlet weak var textView: UITextView!
    
    var payload: [AnyHashable: Any]!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        textView.text = payload.debugDescription

        self.title = "Notification"
    }

    @IBAction func doneTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
