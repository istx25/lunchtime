//
//  LunchtimeLocationManager.h
//  Lunchtime
//
//  Created by Willow Belle on 2015-11-15.
//  Copyright © 2015 Cosmic Labs. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import <Foundation/Foundation.h>

@protocol LunchtimeLocationManagerDelegate <NSObject>

- (void)receivedLocation;

@end

@interface LunchtimeLocationManager : NSObject

@property (nonatomic, weak) id<LunchtimeLocationManagerDelegate> delegate;
@property (nonatomic) CLLocation *currentLocation;

+ (instancetype)defaultManager;

- (void)setup;
- (void)start;
- (void)stop;

@end
