//
//  LunchtimeGoogleMaps.m
//  Lunchtime
//
//  Created by Willow Belle on 2015-11-16.
//  Copyright © 2015 Cosmic Labs. All rights reserved.
//

#import "LunchtimeMaps.h"
#import "Lunchtime-Swift.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import <UIKit/UIKit.h>

static NSString *kBaseGoogleMapsURL = @"comgooglemaps://?";

@implementation LunchtimeMaps

+ (void)openInMapsWithAddress:(NSString *)address {
    if (address == 0) {
        return;
    }

    NSString *encodedAddress = [address stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLUserAllowedCharacterSet]];
    NSURL *GoogleMapsURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@daddr=%@&directionsmode=transit", kBaseGoogleMapsURL, encodedAddress]];

    if ([[UIApplication sharedApplication] openURL: GoogleMapsURL]) {
        [[UIApplication sharedApplication] openURL: GoogleMapsURL];

        return;
    }

    [LunchtimeGeocoder geocodeRequestWithAddress:address handler:^(CLLocationDegrees latitude, CLLocationDegrees longitude) {
        MKPlacemark *endLocation = [[MKPlacemark alloc] initWithCoordinate:CLLocationCoordinate2DMake(latitude, longitude) addressDictionary:nil];
        [[[MKMapItem alloc] initWithPlacemark:endLocation] openInMapsWithLaunchOptions:@{MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeTransit}];
    }];
}

@end
