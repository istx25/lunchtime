//
//  LunchtimeLocationManager.m
//  Lunchtime
//
//  Created by Willow Belle on 2015-11-15.
//  Copyright © 2015 Cosmic Labs. All rights reserved.
//

#import "LunchtimeLocationManager.h"

@interface LunchtimeLocationManager () <CLLocationManagerDelegate>

@property (nonatomic) CLLocationManager *manager;

@end

@implementation LunchtimeLocationManager

+ (instancetype)defaultManager {
    static LunchtimeLocationManager *defaultManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultManager = [self new];
    });

    return defaultManager;
}

#pragma mark - Location Manager Lifecycle
- (void)setup {
    if (self.manager) {
        return;
    }

    [self setManager:[CLLocationManager new]];
    [self.manager setDesiredAccuracy:kCLLocationAccuracyBest];
    [self.manager setDistanceFilter:10];
    [self.manager setDelegate:self];
    [self.manager requestWhenInUseAuthorization];

    NSLog(@"New Location Manager in [LunchtimeLocationManager setup]");
}

- (void)start {
    if (![CLLocationManager locationServicesEnabled]) {
        return;
    }

    switch ([CLLocationManager authorizationStatus]) {
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            [self.manager startUpdatingLocation];
        case kCLAuthorizationStatusAuthorizedAlways:
            [self.manager startUpdatingLocation];
        default:
            [self setup];
    }
}

- (void)stop {
    if (![CLLocationManager locationServicesEnabled]) {
        return;
    }

    if (!self.manager) {
        return;
    }

    [self.manager stopUpdatingLocation];
}

#pragma mark <CLLocationManagerDelegate>
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *location = [locations objectAtIndex:locations.count - 1];

    if (!self.currentLocation.horizontalAccuracy >= location.horizontalAccuracy) {
        return;
    }


    if (!location.horizontalAccuracy <= self.manager.desiredAccuracy) {
        [self stop];
    }

    [self setCurrentLocation:location];
    [self.delegate receivedLocation];
}

@end
