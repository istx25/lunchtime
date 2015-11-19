//
//  SetupPageThirdViewController.swift
//  Lunchtime
//
//  Created by Willow Belle on 2015-11-18.
//  Copyright © 2015 Cosmic Labs. All rights reserved.
//

import UIKit

class SetupPageThirdViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var sharePrivilegeButton: UIButton?

    // MARK: - Actions
    @IBAction func sharePrivilegeButtonPressed(sender: UIButton) {
        LunchtimeLocationManager.defaultManager().setup()
    }
}
