//
//  EnjoyNotification.swift
//  Lunchtime
//
//  Created by Alex on 2015-11-18.
//  Copyright © 2015 Cosmic Labs. All rights reserved.
//

import Foundation
import UIKit

public class EnjoyNotification: UILocalNotification {
    
    public class func enjoyNotification() -> EnjoyNotification! {
        
        let notification = EnjoyNotification()
        notification.fireDate = NSDate(timeIntervalSinceNow: 60*60)
        notification.alertTitle = "We hope you enjoyed your meal!"
        notification.alertBody = "Consider giving the restaurant a rating."
        notification.userInfo = ["notification":"enjoy"]
                
        return notification
    }
}