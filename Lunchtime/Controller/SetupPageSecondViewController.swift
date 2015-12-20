//
//  SetupPageSecondViewController.swift
//  Lunchtime
//
//  Created by Willow Bumby on 2015-11-18.
//  Copyright © 2015 Lighthouse Labs. All rights reserved.
//

import UIKit
import Realm

class SetupPageSecondViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var priceLimitSegmentedControl: UISegmentedControl?

    // MARK: - Controller Lifecycle
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)

        guard let selectedSegmentIndex = priceLimitSegmentedControl?.selectedSegmentIndex else {
            return
        }

        let realm = RLMRealm.defaultRealm()
        let user = User()

        user.priceLimit = selectedSegmentIndex
        user.identifier = NSNumber(integer: 1)

        do {
            realm.beginWriteTransaction()
            User.createOrUpdateInRealm(realm, withValue: user)
            try realm.commitWriteTransaction()
        } catch let error {
            print("Something went wrong...")
            print("Error Reference: \(error)")
        }
    }
}
