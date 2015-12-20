//
//  LunchtimeTableViewCell.swift
//  Lunchtime
//
//  Created by Willow Bumby on 2015-11-18.
//  Copyright © 2015 Lighthouse Labs. All rights reserved.
//

import UIKit

class LunchtimeTableViewCell: UITableViewCell {

    override func setHighlighted(highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)

        if highlighted {
            backgroundColor = .lightGray()
        } else {
            UIView.animateWithDuration(0.2) {
                self.backgroundColor = .clearColor()
            }
        }
    }
}