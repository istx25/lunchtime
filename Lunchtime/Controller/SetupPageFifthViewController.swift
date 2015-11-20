//
//  SetupPageFifthViewController.swift
//  Lunchtime
//
//  Created by Willow Belle on 2015-11-18.
//  Copyright © 2015 Cosmic Labs. All rights reserved.
//

import UIKit
import Realm

class SetupPageFifthViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var picker: UIDatePicker?

    // MARK: - Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        picker?.datePickerMode = .Time
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)

        guard let picker = picker else {
            return
        }
        
        let realm = RLMRealm.defaultRealm()
        let user = User()

        user.lunchtime = picker.date
        user.preferredDistance = NSNumber(integer: 1500)
        user.identifier = NSNumber(integer: 1)
        user.category = "food"

        do {
            realm.beginWriteTransaction()
            User.createOrUpdateInRealm(realm, withValue: user)
            try realm.commitWriteTransaction()
        } catch let error {
            print("Something went wrong...")
            print("Error Reference: \(error)")
        }

        let notification = LunchtimeNotification(date: picker.date)
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
}
