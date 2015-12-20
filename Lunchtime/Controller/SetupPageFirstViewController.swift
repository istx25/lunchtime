//
//  SetupPageFirstViewController.swift
//  Lunchtime
//
//  Created by Willow Bumby on 2015-11-18.
//  Copyright © 2015 Lighthouse Labs. All rights reserved.
//

import UIKit

class SetupPageFirstViewController: UIViewController {
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        guard let navigationController = navigationController else {
            return
        }

        navigationController.setNavigationBarHidden(true, animated: false)
    }
}
