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
        if (error) {
            NSLog(@"Reverse Geocoding Location Error: %@", error);

            return;
        }

        NSArray *placeArray = placemarks;
        CLPlacemark *placemark = placeArray[0];

        completionHandler(placemark);
    }];
}

- (void)geocodeLocationWithAddress:(NSString *)address withCompletionHandler:(void (^)(CLLocationDegrees latitude, CLLocationDegrees longitude))completionHandler {

    CLGeocoder *geocoder = [CLGeocoder new];

    [geocoder geocodeAddressString:address completionHandler:^(NSArray<CLPlacemark *> *placemarks, NSError *error) {
        if (error) {
            NSLog(@"Geocoding Location Error: %@", error);

            return;
        }

        CLPlacemark *placemark = placemarks[0];
        completionHandler(placemark.location.coordinate.latitude, placemark.location.coordinate.longitude);
    }];
}

@end