//
//  LunchtimeLocationManager.h
//  Lunchtime
//
//  Created by Willow Belle on 2015-11-15.
//  Copyright © 2015 Cosmic Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol LunchtimeLocationManagerDelegate <NSObject>

- (void)receivedLocation;

@end

@interface LunchtimeLocationManager : NSObject

@property (nonatomic, weak) id<LunchtimeLocationManagerDelegate> delegate;
@property (nonatomic) CLLocation *currentLocation;

+ (instancetype)defaultManager;
- (BOOL)needsSetup;

- (void)setup;
- (void)start;
- (void)stop;

@end
