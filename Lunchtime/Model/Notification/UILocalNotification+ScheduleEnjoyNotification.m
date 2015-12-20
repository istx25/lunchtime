//
//  UILocalNotification+ScheduleEnjoyNotification.m
//  Lunchtime
//
//  Created by Willow Bumby on 2015-12-20.
//  Copyright © 2015 Lighthouse Labs. All rights reserved.
//

#import "UILocalNotification+ScheduleEnjoyNotification.h"
#import "Lunchtime-Swift.h"

@implementation UILocalNotification (ScheduleEnjoyNotification)

+ (void)scheduleEnjoyNotification {
    NSArray *notifications = [[UIApplication sharedApplication] scheduledLocalNotifications];

    for (UILocalNotification *notification in notifications) {
        NSDictionary *userInfo = notification.userInfo;

        if ([[userInfo objectForKey:@"notification"] isEqualToString:@"enjoy"]) {
            [[UIApplication sharedApplication] cancelLocalNotification:notification];
        }
    }

    EnjoyNotification *notification = [EnjoyNotification enjoyNotification];
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}

@end
