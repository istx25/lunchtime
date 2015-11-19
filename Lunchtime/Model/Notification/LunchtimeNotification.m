//
//  LunchtimeNotification.m
//  Lunchtime
//
//  Created by Alex on 2015-11-16.
//  Copyright © 2015 Cosmic Labs. All rights reserved.
//

#import "LunchtimeNotification.h"

static NSString *kAlertTitle = @"It's Lunchtime!";
static NSString *kAlertBody = @"Open the app to see where to go!";

@implementation LunchtimeNotification

+(instancetype)lunchtimeNotificationWithDate:(NSDate *)date {
    LunchtimeNotification *notification = [[LunchtimeNotification alloc] init];
    notification.fireDate = date;
    notification.repeatInterval = NSCalendarUnitDay;
    notification.alertTitle = kAlertTitle;
    notification.alertBody = kAlertBody;
    
    notification.userInfo = @{@"notification":@"lunchtime"};
    
    return notification;
}

@end
