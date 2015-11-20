//
//  CategoryPopoverViewController.swift
//  Lunchtime
//
//  Created by Willow Belle on 2015-11-19.
//  Copyright © 2015 Cosmic Labs. All rights reserved.
//

import UIKit

class CategoryPopoverViewController: UIViewController, UITableViewDataSource {

    private struct Constants {
        static let ReuseIdentifier = "CategoryCell"
    }

    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var cancelButton: UIButton?
    @IBOutlet weak var saveButton: UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func cancelButtonPressed(sender: UIButton) {

    }

    @IBAction func saveButtonPressed(sender: UIButton) {

    }

    @IBAction func gestureReceived(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    // MARK: - UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Constants.ReuseIdentifier, forIndexPath: indexPath) as? LunchtimeTableViewCell

        guard let lunchtimeCell = cell else {
            return cell! as UITableViewCell
        }

        switch indexPath.row {
        case 0:
            lunchtimeCell.textLabel?.text = "Food"
        case 1:
            lunchtimeCell.textLabel?.text = "Drinks"
        case 2:
            lunchtimeCell.textLabel?.text = "Coffee"
        default:
            break
        }

        return lunchtimeCell
    }
}