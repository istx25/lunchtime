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

- (instancetype)initWithDate:(NSDate *)date {
    self = [super init];

    if (self) {
        self.fireDate = date;
        self.repeatInterval = NSCalendarUnitDay;
        self.alertTitle = kAlertTitle;
        self.alertBody = kAlertBody;
    }
    
    return self;
}

@end
