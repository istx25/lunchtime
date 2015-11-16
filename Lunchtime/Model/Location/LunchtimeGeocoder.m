//
//  LunchtimeGeocoder.m
//  Lunchtime
//
//  Created by Willow Belle on 2015-11-15.
//  Copyright © 2015 Cosmic Labs. All rights reserved.
//

#import "LunchtimeGeocoder.h"

@implementation LunchtimeGeocoder

- (void)reverseGeocodeLocationWithCoordinate:(CLLocationCoordinate2D)coordinate withCompletionHandler:(void (^)(CLPlacemark *placemark))completionHandler {

    CLLocation *location = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    CLGeocoder *geocoder = [CLGeocoder new];

    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> *placemarks, NSError *error) {
        NSArray *placeArray = placemarks;
        CLPlacemark *placemark = placeArray[0];

        completionHandler(placemark);
    }];
}


@end
