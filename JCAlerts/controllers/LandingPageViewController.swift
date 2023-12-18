//
//  LandingPageViewController.swift
//  JCAlerts
//
//  Created by John Choi on 12/16/23.
//

import UIKit
import SwiftUI

class LandingPageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // 1
        let landingPageView = LandingPageView()
        let vc = UIHostingController(rootView: landingPageView)

        let swiftuiView = vc.view!
        swiftuiView.translatesAutoresizingMaskIntoConstraints = false

        // 2
        // Add the view controller to the destination view controller.
        addChild(vc)
        view.addSubview(swiftuiView)

        // 3
        // Create and activate the constraints for the swiftui's view.
        NSLayoutConstraint.activate([
            swiftuiView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            swiftuiView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])

        // 4
        // Notify the child view controller that the move is complete.
        vc.didMove(toParent: self)
    }
}
