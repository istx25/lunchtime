//
//  LunchtimeNotification.h
//  Lunchtime
//
//  Created by Alex on 2015-11-16.
//  Copyright © 2015 Lighthouse Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LunchtimeNotification : UILocalNotification

+(instancetype)lunchtimeNotificationWithDate:(NSDate *)date;

@end
