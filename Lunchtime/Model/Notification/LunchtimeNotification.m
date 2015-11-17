//
//  LunchtimeNotification.m
//  Lunchtime
//
//  Created by Alex on 2015-11-16.
//  Copyright © 2015 Cosmic Labs. All rights reserved.
//

#import "LunchtimeNotification.h"

@implementation LunchtimeNotification

- (instancetype)initWithDate:(NSDate *)date {
    self = [super init];

    if (self) {
        self.fireDate = date;
        self.repeatInterval = NSCalendarUnitDay;
        self.alertTitle = @"It's Lunchtime!";
        self.alertBody = @"I hope you're hungry.";
    }
    
    return self;
}

@end
