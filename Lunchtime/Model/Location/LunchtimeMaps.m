//
//  LunchtimeGoogleMaps.m
//  Lunchtime
//
//  Created by Willow Belle on 2015-11-16.
//  Copyright © 2015 Cosmic Labs. All rights reserved.
//

#import "LunchtimeMaps.h"
#import "LunchtimeGeocoder.h"
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

    if (![[UIApplication sharedApplication] openURL: GoogleMapsURL]) {
        LunchtimeGeocoder *geocoder = [LunchtimeGeocoder new];
        [geocoder geocodeLocationWithAddress:address withCompletionHandler:^(CLLocationDegrees latitude, CLLocationDegrees longitude) {
            CLLocationCoordinate2D endingCoord = CLLocationCoordinate2DMake(latitude, longitude);
            MKPlacemark *endLocation = [[MKPlacemark alloc] initWithCoordinate:endingCoord addressDictionary:nil];
            MKMapItem *endingItem = [[MKMapItem alloc] initWithPlacemark:endLocation];

            NSMutableDictionary *launchOptions = [[NSMutableDictionary alloc] init];
            [launchOptions setObject:MKLaunchOptionsDirectionsModeTransit forKey:MKLaunchOptionsDirectionsModeKey];

            [endingItem openInMapsWithLaunchOptions:launchOptions];
        }];

        return;
    }

    [[UIApplication sharedApplication] openURL: GoogleMapsURL];
}

@end
