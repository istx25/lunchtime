//
//  SetupPageSixthViewController.swift
//  Lunchtime
//
//  Created by Willow Belle on 2015-11-18.
//  Copyright © 2015 Cosmic Labs. All rights reserved.
//

import UIKit

class SetupPageSixthViewController: UIViewController {

    // MARK: - Constants
    private struct Constants {
        static let UserCreatedFlag = "USER_CREATED"
        static let SegueFromSetupFlow = "segueFromSetupFlow"
    }

    // MARK: - Outlets
    @IBOutlet weak var doneButton: UIButton?

    // MARK: - Actions
    @IBAction func doneButtonPressed(sender: UIButton) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(Constants.UserCreatedFlag, forKey: Constants.UserCreatedFlag)
        performSegueWithIdentifier(Constants.SegueFromSetupFlow, sender: self)
    }
}
