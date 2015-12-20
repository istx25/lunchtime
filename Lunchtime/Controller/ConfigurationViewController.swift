//
//  ConfigurationViewController.swift
//  Lunchtime
//
//  Created by Willow Bumby on 2015-12-20.
//  Copyright © 2015 Lighthouse Labs. All rights reserved.
//

import UIKit

class ConfigurationViewController: UITableViewController {

    // MARK: Constants
    private static let AlertTitle = "This will delete all restaurant data and reset all settings."
    private static let DistanceLabel = "Search Distance"
    private static let SegueToOnboardingFlowAfterDestruction = "segueToOnboardingFlowAfterDestruction"
    private static let UserCreatedFlag = "USER_CREATED"

    // MARK: Properties
    @IBOutlet weak var notificationSwitch: UISwitch!
    @IBOutlet weak var lunchtimeDatePicker: UIDatePicker!
    @IBOutlet weak var priceLimitSegmentedControl: UISegmentedControl!
    @IBOutlet weak var distanceSlider: UISlider!
    @IBOutlet weak var distanceLabel: UILabel!
    var user: User?

    // MARK: Controller Lifecycle
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        user = User(forPrimaryKey: NSNumber(integer: 1))
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(false, animated: false)
        self.configureLayout()
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)

        self.commitRealmChanges()
        self.scheduleLunchtimeNotification()
    }

    // MARK: Layout
    func configureLayout() {
        distanceSlider.value = user!.preferredDistance.floatValue
        distanceLabel.text = "\(ConfigurationViewController.DistanceLabel) (\(user!.preferredDistance.stringValue) meters)"
        priceLimitSegmentedControl.selectedSegmentIndex = user!.priceLimit
        lunchtimeDatePicker.date = user!.lunchtime
        lunchtimeDatePicker.datePickerMode = .Time

        if UIApplication.sharedApplication().scheduledLocalNotifications?.count == 0 {
            notificationSwitch.on = false
        } else {
            notificationSwitch.on = true
        }
    }

    // MARK: Actions
    @IBAction func distanceSliderValueDidChange(sender: UISlider) {
        let distance = NSNumber(integer: Int(distanceSlider.value))
        distanceLabel.text = "\(ConfigurationViewController.DistanceLabel) (\(distance.stringValue) meters)"
    }

    // MARK: Data and Notifications
    func scheduleLunchtimeNotification() {
        guard notificationSwitch.on else { UIApplication.sharedApplication().cancelAllLocalNotifications(); return }
        guard let notifications = UIApplication.sharedApplication().scheduledLocalNotifications else { return }

        for notification in notifications {
            let userInfo = notification.userInfo!

            if "lunchtime" == userInfo["notification"] as! String {
                UIApplication.sharedApplication().cancelLocalNotification(notification)
            }

            let new = LunchtimeNotification(date: lunchtimeDatePicker.date)
            UIApplication.sharedApplication().scheduleLocalNotification(new)
            print("New notification: \(notification.fireDate), Notification count: \(UIApplication.sharedApplication().scheduledLocalNotifications?.count)")
        }
    }

    func commitRealmChanges() {
        if RLMRealm.defaultRealm().isEmpty { return }

        RLMRealm.defaultRealm().beginWriteTransaction()
        user?.preferredDistance = NSNumber(float: distanceSlider.value)
        user?.priceLimit = priceLimitSegmentedControl.selectedSegmentIndex
        user?.lunchtime = lunchtimeDatePicker.date

        do { try RLMRealm.defaultRealm().commitWriteTransaction() } catch {
            print("Something went wrong...")
        }
    }

    // MARK: UITableViewDelegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.row {
        case 4:
            let alert = UIAlertController(title: ConfigurationViewController.AlertTitle, preferredStyle: .ActionSheet)
            alert.addCancelAction()
            alert.addDestructiveAction(title: "Erase All Restaurant Data") {
                RLMRealm.defaultRealm().beginWriteTransaction()
                RLMRealm.defaultRealm().deleteAllObjects()
                try! RLMRealm.defaultRealm().commitWriteTransaction()

                self.performSegueWithIdentifier(ConfigurationViewController.SegueToOnboardingFlowAfterDestruction, sender: self)
                NSUserDefaults.standardUserDefaults().removeObjectForKey(ConfigurationViewController.UserCreatedFlag)
            }

            presentViewController(alert, animated: true, completion: nil)
        default:
            print("Default State")
            break
        }

    }
}